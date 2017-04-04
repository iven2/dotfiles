#!/usr/bin/python -B

import os
import sys

print """This scripts determines the memory used by the system at the current moment in MB"""
cmd = """ps aux  | awk '{print $6/1024 " MB         " $11}'  | sort -n > memory.garbage"""
os.system(cmd)

with open('./memory.garbage') as f:
    total = 0
    for line in f:
        tokens = line.split()
        total += float(tokens[0])
    print total, 'MB'
