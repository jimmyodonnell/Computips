#!/usr/bin/env awk

# This script simply demonstrates using awk code in a standalone script
# Usage: awk -f script.awk file.txt

BEGIN {
    print "Processing file"
}

NR%10==0

END {
    print "Finished processing"
}
