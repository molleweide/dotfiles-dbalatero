#!/usr/bin/env bash

# TODO: make more different sizes of headers
#   1. very large scripts start
#   2. sub script header
#   3. ??
#   4. dotsay = small info

dotheader() {
    echo
    echo
    echo -e "\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo
    dotsay "@b@blue[[ $1 ]]"
    echo
    echo -e ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n"
}

dotsay() {
    local result=$(_colorized $@)
    echo -e "$result"
}

_colorized() {
    echo "$@" | sed -E \
        -e 's/((@(red|green|yellow|blue|magenta|cyan|white|reset|b|u))+)[[]{2}(.*)[]]{2}/\1\4@reset/g' \
        -e "s/@red/$(tput setaf 1)/g" \
        -e "s/@green/$(tput setaf 2)/g" \
        -e "s/@yellow/$(tput setaf 3)/g" \
        -e "s/@blue/$(tput setaf 4)/g" \
        -e "s/@magenta/$(tput setaf 5)/g" \
        -e "s/@cyan/$(tput setaf 6)/g" \
        -e "s/@white/$(tput setaf 7)/g" \
        -e "s/@reset/$(tput sgr0)/g" \
        -e "s/@b/$(tput bold)/g" \
        -e "s/@u/$(tput sgr 0 1)/g"
    }
