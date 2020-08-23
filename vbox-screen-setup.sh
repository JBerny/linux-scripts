#!/bin/bash

# Horizontal size in pixels, i.e. 1920
X=$1
# Vertical size in pixels, i.e. 1080
Y=$2
#Refresh Rate in Hz, i.e. 60 
RR=$3

if test "X$1X" == "XX" || test "X$2X" == "XX" || test "X$3X" == "XX"; then 
  echo "missing args"
  exit 1
fi

CVTOUT=$(cvt $X $Y $RR)
CVTOUT=${CVTOUT/*Modeline /}
MODELINE=$( echo "$CVTOUT" | tr -d '"' )
MODE=$(echo $MODELINE | cut -d' ' -f1)
MONITOR=$(xrandr --query | grep " connected" | head -1 | cut -d' ' -f1 )
echo "Found monitor $MONITOR"
echo "Creating mode $MODELINE"
xrandr --newmode ${MODELINE}
echo "Resizing $MONITOR with $MODE"
xrandr --addmode $MONITOR "$MODE"
xrandr --output $MONITOR --mode "$MODE"
