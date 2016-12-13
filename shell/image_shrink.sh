#!/usr/bin/env bash

# reduce size of images from the command line!

​sips -Z 1024 *.JPG --out /Users/jimm/photo/scaleddown/

# -Z preserves aspect ratio
# 1024 is the maximum side length
# *.jpg performs the operation on all files ending in .jpg
# --out sets an output directory
