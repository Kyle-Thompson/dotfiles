#!/usr/bin/python

import subprocess

def bytestr_to_str(bstr):
# This can fail if the bystring isn't valid ascii
    return str(bstr, 'utf-8')

call_internal = lambda cmd: subprocess.check_output(cmd, shell=True).splitlines()
call = lambda cmd: [bytestr_to_str(line) for line in call_internal(cmd)]

def line_to_title(line):
    title = ' '.join(line.split()[4:])
    if len(title) > 30:
        title = title[:27] + '...'
    return title

def get_attr(line, index):
    return line.split()[index]

def pid_to_name(pid):
    return call('ps -p {} -o comm='.format(pid))[0]


class Process(object):
    def __init__(self, line):
        self.id = get_attr(line, 0)
        self.window = get_attr(line, 1)
        self.pid = get_attr(line, 2)
        self.hostname = get_attr(line, 3)
        self.title = line_to_title(line)
        self.name = pid_to_name(self.pid)

    def __str__(self):
        if self.name != self.title:
            return '{}: {}'.format(self.name, self.title)
        else:
            return self.title


def valid_processes():
    non_sticky_window = lambda p: p.window != '-1'
    processes = [Process(line) for line in call("wmctrl -lp")]
    return [p for p in processes if non_sticky_window(p)]

for process in valid_processes():
    print(process)
