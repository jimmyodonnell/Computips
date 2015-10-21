#!/bin/bash

# update macports stuff (I think that's what this does...)

sudo port selfupdate

sudo port upgrade outdated

# install gcc45
sudo port install gcc45
sudo port install gcc_select
sudo port select gcc mp-gcc45
#Selecting 'mp-gcc45' for 'gcc' succeeded. 'mp-gcc45' is now active.
