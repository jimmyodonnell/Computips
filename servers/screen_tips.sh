#!/usr/bin/env bash

# tips for using screen

# start screen

screen -S sessionname


# Once something is running (and you lose your prompt), you can detach the screen session (disconnect it from the terminal and put it into the background)
ctrl+a,d or ctrl+a,ctrl+d

# then, you can log off of the server (exit ssh session):
exit

# and then come back to the same session by logging back into the server (ssh ...) and doing
screen -r 

# to start a new shell (screen? session??):
ctrl+a,c

# to switch between shells (screens?? sessions???)
# hit ctrl+a then the number of the session, e.g.:
ctrl+a,2


# to resume session (including one started in a different location):
screen -d -R sessionname


# get help once screen is started
ctrl+a,?

# list all screens
screen ls

# list all windows you currently have open
ctrl+a,"

# advance to the next window
ctrl+a,ctrl+n

# go to the previous window
ctrl+a,ctrl+p

