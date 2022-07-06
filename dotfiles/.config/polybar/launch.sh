#!/bin/bash

killall -q polybar

polybar --config=$HOME/.config/polybar/config.ini swagbar 2>&1 | tee -a /tmp/polybar.log | echo > inutile.log  &

echo "Polybar launched..."
