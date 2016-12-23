#!/bin/bash

#
# check is a command tool exists
# hongjin.cao
#

function CHECK_EXIST()
{
    command -v "$@" >/dev/null 2>&1 || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
    #type "$@" >/dev/null 2>&1 || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
    #hash "$@" 2>/dev/null || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
}


CHECK_EXIST inofitywait 
CHECK_EXIST foo

#command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
#type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
#hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
