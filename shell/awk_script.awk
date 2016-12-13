#!/usr/bin/env awk

# This script simply demonstrates using awk code in a standalone script
# it prints some messages and every 10th line of a file.
# Usage: awk -f awk_script.awk file.txt

BEGIN {
    print "Processing file"
}

NR%10==0

END {
    print "Finished processing"
}
