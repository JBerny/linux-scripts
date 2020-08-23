#!/bin/bash

# Horizontal size in pixels, i.e. 1920
X=$1
# Vertical size in pixels, i.e. 1080
Y=$2
#Refresh Rate in Hz, i.e. 60 
RR=$3

CVTOUT=$(cvt $X $Y $RR)
MODELINE=${CVTOUT/*Modeline/}
MODE=$(echo $MODELINE | | cut -d' ' -f1)
MONITOR=$(xrandr --query | grep " connected" | head -1 | cut -d' ' -f1)
xrandr --addmode $MONITOR "$MODE"
xrandr --output $MONITOR --mode "$MODE"
