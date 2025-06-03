#!/bin/bash

WALL=~/dotfiles/wallpapers/10-6-Server.jpg
BLURRED=/tmp/i3lock_blur.png

# Create a blurred version of the wallpaper
magick "$WALL" -gravity center -extent 1920x1080 -blur 0x8 "$BLURRED"

# Lock screen with i3lock and blue tint
i3lock \
  -i "$BLURRED" \
  --inside-color=00000088 \
  --ring-color=3b82f6 \
  --line-color=00000000 \
  --keyhl-color=60a5fa \
  --bshl-color=2563eb \
  --separator-color=00000000 \
  --insidever-color=1e40af88 \
  --ringver-color=1e40af \
  --insidewrong-color=dc262688 \
  --ringwrong-color=dc2626 \
  --time-color=93c5fd \
  --date-color=bfdbfe \
  --layout-color=bfdbfe \
  --greeter-color=bfdbfe

