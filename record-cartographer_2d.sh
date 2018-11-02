#!/bin/bash

set -eux

# run recordmydesktop in the background
recordmydesktop --no-sound --no-cursor --display $DISPLAY &
RECORDMYDESKTOP_PID=$!

# Launch the 2D backpack demo.
roslaunch ./demo_backpack_2d.launch bag_filename:=`pwd`/cartographer_paper_deutsches_museum.bag

# terminate recordmydesktop
kill -s TERM $RECORDMYDESKTOP_PID || true
wait $RECORDMYDESKTOP_PID || true

