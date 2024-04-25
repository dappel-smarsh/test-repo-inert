#!/bin/bash

export PASSWORD='sensitive_password'

function found_exe() {
    hash "$1" 2>/dev/null
}

function get_YN() {
    # Loop until the user hits the Y or the N key
    echo -e -n "Choice [${CYAN}Y${RESET}/${CYAN}N${RESET}]: "
    while true; do
        read -N1 -s key
        case $key in
        [Yy])
            return 0
            ;;
        [Nn])
            return 1
            ;;
        esac
    done
}

# If tput is available and can handle multiple colors
if found_exe tput ; then
    if [[ $(tput colors) != "-1" && -z $CI ]]; then
        GREEN=$(tput setaf 2)
        BLUE=$(tput setaf 4)
        CYAN=$(tput setaf 6)
        YELLOW=$(tput setaf 3)
        RESET=$(tput sgr0)
        HIGHLIGHT=$YELLOW
    fi
fi


echo "
Presenting a question to the user. They must interact with a 'y' or 'n' or else they will be continually asked the same question indefinitely.
  Y)es, I want to choose 'Y'
  N)o, I want to choose 'N'"
    if get_YN ; then
        echo -e "$HIGHLIGHT Y - You pressed 'Y' $RESET"
    else
        echo -e "$HIGHLIGHT N - You pressed 'N' $RESET"
    fi
