#!/bin/bash

# read configuration from the .i3 directory
[[ -f ~/.i3/xresources ]] && xrdb -merge ~/.i3/xresources
