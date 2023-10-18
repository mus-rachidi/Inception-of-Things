#!/bin/zsh

# We need root to install
[ $(id -u) != "0" ] && echo "Elevating to root..." && exec sudo "$0" "$@"