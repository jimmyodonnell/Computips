#!/usr/bin/env bash

# How to install from source, from: http://www.linuxquestions.org/questions/linux-general-1/useful-thread-and-information-about-installing-programs-45094/
# Basically this short how-to will explain how to install those tar.gz and .tgz type files. It will cover the basic commands and steps to get you to install a program from source with no problems, or at least get you in the right direction.
# So we'll take an example download program, gaim for example since its popular and commonly asked on this site on how to install from source.
# After you download gaim which I believe the latest stable version is gaim-0.59.8.tar.gz, most of the time it will download to your home directory by default unless you specify elsewhere. The first thing we want to do is cd into the directory where we've downloaded it.

cd ~

# The command above will change you automatically to your current users home directory. There you should find your newly downloaded gaim-0.59.8.tar.gz. The next step/command involves the extraction of the files that are tarballed.

tar xvf gaim-0.59.8.tar.gz

# This should extract the files into a new directory usually named the same as the file without the tar.gz at the end. In this case this would create a directory named ~/gaim-0.59.8 At times you will also need to use the z flag if the file is compressed thru gzip, most of the time you will know cause it will spit an error out saying that it is compressed, etc. To run this option you would use something like this:

tar xzvf gaim-0.59.8.tar.gz

# However if you ever wanted to extract to another directory you've created, name it something else besides the default name or an existing directory you can run a command like this:

tar xvf gaim-0.59.8.tar.gz -C new-directory

# Now that you have it extracted, you will then need to cd into the new directory where all the files are located.

cd gaim-0.59.8

# From this point we need to configure and compile the program now. Take note the following steps are the basic way to install from source, some programs might differ as most will always be tarballed with a INSTALL, README or both files. It is always a good idea to read these files to find specific instructions on how to install any particular program.
# Follow these steps to install the program from a command or terminal after cd'ing into the directory you just  extracted the program to:

./configure

# This will basically check for required components on your system, better known as dependencies and also build your make file. If you don't get any errors then you will want to go to the next step to make.

make

# Now from this point after make we'll want to perform the make install as root. This is usually done as root as it will need access to particular parts of your system where a regular user has no rights to write to.

su -m
[root password prompt]
make install
exit

# Basically that su -m will prompt you for the root password but after logging in, with the -m flag it will keep you in the existing directory you were working from instead of placing you in root's home directory. The exit command will log you out of being root.
# Now its optional but to clean up any temp files that were created you can do this:

make clean

