#!/usr/bin/env python3

'''
Parse arguments in python

source: http://stackoverflow.com/questions/7427101/dead-simple-argparse-example-wanted-1-argument-3-results
'''

import argparse
import sys # required for sys.exit(0) on exception

# describe the program -- this will print with help
parser = argparse.ArgumentParser(description = 'ARG-DOG: A program to process those doggone arguments')

# (Note that argparse replaces '-' in your argument names with underscores when naming the variables.)

parser.add_argument('-f', '--foo', default = 'foobar', 
  help = 'Description for foo argument', 
  required = True)

parser.add_argument('-b', '--bar', default = 3.14, 
  help = 'Description for bar argument', 
  required = True)

# In many situations you may wish to use arguments simply as flags which take no value. You can add those in argparse like this:

parser.add_argument('-c', '--cats', action = 'store_true', 
  help = 'this is the cats option')

parser.add_argument('-d', '--dogs', action = 'store_false', 
  help = 'this is the dogs option')

# The above will create variables named 'foo' with value True, and 'no_foo' with value False, respectively.


################################################################################
# Include this to print help if no arguments are given, but in order to work, at least one argument must be mandatory. (requires 'import sys')
try:
    options = parser.parse_args()
except:
    parser.print_help()
    sys.exit(0)
# In a real scenario, you would wrap the try/except around the actual parse_args call used to process arguments
################################################################################


# By default, the object you get back from parse_args() is a 'Namespace' object: An object whose member variables are named after your command-line arguments. The Namespace object is how you access your arguments and the values associated with them:

# in that case, you access the argument values in this way:
# args = parser.parse_args()
# print(args.my_foo)
# print(args.bar_value)

# alternatively, you can create a dictionary structure of your arguments using the vars function:

args = vars(parser.parse_args())

# args will be a dictionary containing the arguments:

if args['foo'] == 'Hello':
    print("foo argument is Hello")
elif args['foo'] == 'Bonjour':
    print("foo argument est Bonjour")
else:
    print("foo argument is neither Hello nor Bonjour")

if args['bar'] == 'World':
    print(args['bar'])
else:
    print("bar argument is not World")

if (args['cats']):
    print("cats is true")

if (args['dogs'] is False):
    print("dogs is false")




