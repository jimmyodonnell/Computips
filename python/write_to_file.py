#!/usr/bin/env python

# to append to an existing file (or write it, if it doesn't exist, use 'a')

with open('target.txt','w') as out:
    line1 = raw_input("line 1: ")
    line2 = raw_input("line 2: ")
    line3 = raw_input("line 3: ")
    print("I'm going to write these to the file.")
    out.write('{}\n{}\n{}\n'.format(line1,line2,line3))

# OR

target.write("%s \n %s \n %s \n" % (line1, line2, line3))

# OR

target.writelines([line1, line2, line3])


