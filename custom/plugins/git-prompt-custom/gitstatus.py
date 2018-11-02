#!/usr/bin/env python3

import sys
from subprocess import Popen, PIPE

# `git status --porcelain --branch` can collect all information
# branch, remote_branch, untracked, staged, changed, conflicts, ahead, behind
po = Popen(['git', 'status', '--porcelain', '--branch'], stdout=PIPE, stderr=PIPE)
stdout, sterr = po.communicate()

git="0"
branch="none"
dirty="0"
if po.returncode == 0:
    git = "1"
    lines = stdout.decode('utf-8').splitlines()
    s = lines[0]
    start = s.index(' ')
    branch = 'ERROR'
    if '.' in s:
        branch = s[s.index(' ')+1:s.index('.')]
    else:
        branch = s[s.index(' ')+1:]

    dirty = "0"
    if len(lines) > 1: dirty = "1"

out = ' '.join([git, branch, dirty])
print(out, end='')
