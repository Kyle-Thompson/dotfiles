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
 * - fetch colors from xresources.
 * - make async / multithreaded
 * - add compile time checks to see if:
 *   - Xlib is installed
 *   - Xresources colors exist
 *
 * Future work:
 * - Turn into daemon?
 *   - After cding into git dir, run functions to get info and spawn daemon.
 *   - daemon monitors the state of the git repo and updates internal tracking variables.
 *   - This blocks the need to rerun information retrieval commands for every new prompt.
 */

#define PIPE_NULL " > /dev/null 2>&1"

struct RGB {
    int red;
    int green;
    int blue;

    RGB(int r, int g, int b)
    : red(r), green(g), blue(b)
    {}

    RGB(const std::string& code) 
    : red(strtol(code.substr(1, 2).c_str(), nullptr, 16))
    , green(strtol(code.substr(3, 2).c_str(), nullptr, 16))
    , blue(strtol(code.substr(5, 2).c_str(), nullptr, 16))
    {}

    std::string to_string() {
        char buffer[22];
        sprintf(buffer, "\033[38;2;%d;%d;%dm", red, green, blue);
        return std::string(buffer);
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

std::vector<RGB> get_colors() {
    std::vector<RGB> colors;
    colors.reserve(5);

    XrmInitialize();
    std::unique_ptr<Display, int(*)(Display*)> dpy(XOpenDisplay(NULL), XCloseDisplay);
    // TODO: if (!dpy) throw error
    char* resource_manager = XResourceManagerString(dpy.get());
    // TODO: if (!resource_manager) throw error
    XrmDatabase db = XrmGetStringDatabase(resource_manager);
    // TODO: if (!db) throw error
  
    // 2 = green, 3 = yellow
    std::array<const char*, 2> color_codes = {{ "color2", "color3" }};
    XrmValue ret;
    char* type;
    for (auto color_code : color_codes) {
        XrmGetResource(db, color_code, "String", &type, &ret);
        if (ret.addr != NULL && !strncmp("String", type, 64))
            colors.emplace_back(ret.addr);
        // TODO: else throw error
    }

    return colors;
}

int main() {

    // Check if pwd is in a git repo.
    if (cmd_status("git rev-parse --is-inside-work-tree" PIPE_NULL)) {
        return 0;
    }

    auto colors = get_colors();

    std::future<bool> unstaged = std::async(has_unstaged_files);
    std::future<bool> untracked = std::async(has_untracked_files);
    char* branch = get_current_branch();
    std::future<std::string> ahead_behind = std::async(get_ahead_behind, branch);

    printf("%s[(%s)%s%s]%s ",
           unstaged.get() ? colors[1].to_string().c_str() : colors[0].to_string().c_str(),
           branch,
           ahead_behind.get().c_str(),
           untracked.get() ? " ?" : "",
           reset_color);
}
