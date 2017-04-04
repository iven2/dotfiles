#!/usr/bin/env python

import os
import sys

print '''
This file removes duplicate and common commands from ~/.bash_eternal_history and saves results in final_out.garbage
'''

cmd = ''' cat ~/.bash_eternal_history  | awk '{ s = ""; for (i = 11; i <= NF; i++) s = s $i " "; print s }' > tttttttttttmp_out '''
os.system(cmd)

cmd = ''' sort tttttttttttmp_out | uniq > sorted_tttttttttttmp_out'''
os.system(cmd)

with open('sorted_tttttttttttmp_out') as f:
    content = f.readlines()

with open('new_sorted_tttttttttttmp_out', 'w') as f:
    # we need this second to modify the lines with lead digits because whenever we are using "screen", bash_eternal_history will contain an extra number indicating screen numbers
    # Therefore, we need to remove the leading digits for these lines
    for line in content:
        tokens = line.split(' ')
        if(tokens[0].isdigit()):
            f.write(line[len(tokens[0]) + 1:])
        else:
            f.write(line)

cmd = ''' sort new_sorted_tttttttttttmp_out | uniq > tttttttttttmp_out '''
os.system(cmd)


with open('tttttttttttmp_out') as f:
    content = f.readlines()

# content = [x.strip() for x in content]

def check_line_starts_with(line, keywords):
    for k in keywords:
        if(line.startswith(k + ' ')):
           return True
    return False

with open('final_out.garbage', 'w') as f:
    keywords = ['ls', 'e', 'which', 'rm', 'cat', 'bower', 'cd', 'diff', 'git', 'find', 'grep', 'mv', 'npm', 'mkdir', 'cp', 'forever', 'grunt', 'ps aux', 'yo', 'wget']
    keywords += ['byobu', 'wc -l', 'tail', 'touch', 'rmdir', 'gulp','scp', 'ssh']
    for line in content:
        if check_line_starts_with(line, keywords):
            pass
        else:
            f.write(line)

os.system('rm -f ./tttttttttttmp_out ./sorted_tttttttttttmp_out ./new_sorted_tttttttttttmp_out')
os.system('wc -l final_out.garbage')
