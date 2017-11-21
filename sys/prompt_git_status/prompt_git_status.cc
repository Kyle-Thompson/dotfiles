#include <algorithm>
#include <cstdio>
#include <string.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <future>
#include <vector>

#include <X11/Xlib.h>
#include <X11/Xresource.h>

/*
 * TODO
 * - optimize staged/untracked into one call to git status that they both look through.
 * - test if async approach is faster.
 * - add compile time checks to see if:
 *   - Xlib is installed
 *
 * Future work:
 * - Determine way to hold and update git info rather than re-query every time.
 */

#define PIPE_NULL " > /dev/null 2>&1"

struct RGB {
    int red;
    int green;
    int blue;
    std::string repr;

    RGB(int r, int g, int b)
    : red(r), green(g), blue(b)
    {
        char buffer[22];
        sprintf(buffer, "\033[38;2;%d;%d;%dm", red, green, blue);
        repr = std::string(buffer);
    }

    RGB(const std::string& code) 
    : red(strtol(code.substr(1, 2).c_str(), nullptr, 16))
    , green(strtol(code.substr(3, 2).c_str(), nullptr, 16))
    , blue(strtol(code.substr(5, 2).c_str(), nullptr, 16))
    {
        char buffer[22];
        sprintf(buffer, "\033[38;2;%d;%d;%dm", red, green, blue);
        repr = std::string(buffer);
    }

    operator const char*() {
        return repr.c_str();
    }
};

const char* reset_color = "\033[0m";

bool cmd_status(const char* cmd) {
    return WEXITSTATUS(system(cmd));
}

auto cmd_pipe(const char* cmd) {
    std::unique_ptr<FILE, int(*)(FILE*)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) throw std::runtime_error("popen() failed!");
    return pipe;
}

bool has_untracked_files() {
    return cmd_status("git status --porcelain | grep '\?\?'" PIPE_NULL) == 0;
}

bool has_unstaged_files() {
    return cmd_status("git status --porcelain | grep -E '\\bM'" PIPE_NULL) == 0;
}

auto untracked_unstaged() {
    bool unstaged = false, untracked = false;
    auto pipe = cmd_pipe("git status --porcelain");
    for (char buffer[512]; fgets(buffer, 512, pipe.get()) && !unstaged && !untracked;) {
        if (!strncmp(buffer+1, "M", 1)) unstaged = true;
        else if (!strncmp(buffer+1, "??", 2)) untracked = true;
    }
    return std::make_tuple(untracked, unstaged);
}


int count_ahead(const char* branch){
    char command[256];
    sprintf(command, "git rev-list %s@{upstream}..HEAD", branch);
    auto pipe = cmd_pipe(command);

    int sum = 0;
    char buffer[64];
    for (; fgets(buffer, 64, pipe.get()); ++sum);

    return sum;
}

int count_behind(const char* branch){
    char command[256];
    sprintf(command, "git rev-list HEAD..%s@{upstream}", branch);
    auto pipe = cmd_pipe(command);
    
    int sum = 0;
    char buffer[64];
    for (; fgets(buffer, 64, pipe.get()); ++sum);

    return sum;
}

std::string get_ahead_behind(const char* branch) {
    char* buffer = (char*) malloc(sizeof(char) * 8); // TODO: Avoid this dynamic allocation.
    int behind = count_behind(branch);
    int ahead = count_ahead(branch);

    if (!behind && !ahead) {
        sprintf(buffer, "");
    } else if (!behind) {
        sprintf(buffer, " +%d", ahead);
    } else if (!ahead) {
        sprintf(buffer, " -%d", behind);
    } else {
        sprintf(buffer, " %d/%d", behind, ahead);
    }

    return std::string(buffer); // TODO: Return char* instead of string.
}

char* get_current_branch() {
    char* buffer = (char*) malloc(sizeof(char) * 128); // TODO: Avoid this dynamic allocation.
    auto pipe = cmd_pipe("git branch");

    while (fgets(buffer, 128, pipe.get())) {
        if (buffer[0] == '*') {
            buffer[strlen(buffer)-1] = 0;
            return buffer + 2;
        }
    }

    strncpy(buffer, "ERROR", 5);
    return buffer;
}

auto get_colors() {
    auto white = RGB(255, 255, 255);
    
    XrmInitialize();
    std::unique_ptr<Display, int(*)(Display*)> dpy(XOpenDisplay(NULL), XCloseDisplay);
    if (!dpy) return std::make_tuple(white, white, white);
    char* resource_manager = XResourceManagerString(dpy.get());
    if (!resource_manager) return std::make_tuple(white, white, white);
    XrmDatabase db = XrmGetStringDatabase(resource_manager);
    if (!db) return std::make_tuple(white, white, white);
 
    // TODO: clean this up.
    std::vector<RGB> colors;
    XrmValue ret;
    char* type;
    for (auto& color_code : {"color1", "color2", "color3"}) {
        XrmGetResource(db, color_code, "String", &type, &ret);
        if (ret.addr != nullptr && !strncmp("String", type, 64))
            colors.emplace_back(ret.addr);
        else
            colors.push_back(white);
    }

    return std::make_tuple(colors[0], colors[1], colors[2]);
}

void run() {
    std::future<bool> unstaged = std::async(has_unstaged_files);
    std::future<bool> untracked = std::async(has_untracked_files);
    char* branch = get_current_branch();
    std::future<std::string> ahead_behind = std::async(get_ahead_behind, branch);
    
    auto [red, green, yellow] = get_colors();

    printf("%s[(%s)%s%s]%s ",
           //unstaged.get() ? yellow : green,
           unstaged.get() ? yellow.repr.c_str() : green.repr.c_str(),
           branch,
           ahead_behind.get().c_str(),
           untracked.get() ? " ?" : "",
           reset_color);
}

int main() {

    // Check if pwd is in a git repo.
    if (cmd_status("git rev-parse --is-inside-work-tree" PIPE_NULL)) {
        return 0;
    }

    try {
        run();
    } catch (const std::runtime_error& e) {
        printf("GIT_PROMPT_ERROR %s", e.what());
    }
}
