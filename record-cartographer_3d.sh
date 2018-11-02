#!/bin/bash

set -eux

# run recordmydesktop in the background
recordmydesktop --no-sound --no-cursor --display $DISPLAY &
RECORDMYDESKTOP_PID=$!

# Launch the 3D backpack demo.
roslaunch ./demo_backpack_3d.launch bag_filename:=`pwd`/b3-2016-04-05-14-14-00.bag

# terminate recordmydesktop
kill -s TERM $RECORDMYDESKTOP_PID || true
wait $RECORDMYDESKTOP_PID || true

