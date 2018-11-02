#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

set -eu

apt-get update
apt-get install -y sudo wget xcompmgr xvfb openbox recordmydesktop
sudo apt-get install -y python-wstool python-rosdep ninja-build

mkdir catkin_ws
cd catkin_ws
wstool init src

# Merge the cartographer_ros.rosinstall file and fetch code for dependencies.
wstool merge -t src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src

# Install deb dependencies.
# The command 'sudo rosdep init' will print an error if you have already
# executed it since installing ROS. This error can be ignored.
sudo rosdep init || true
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

# Build and install.
# catkin_make_isolated --install --use-ninja
# source install_isolated/setup.bash
tar xzf /mnt/cartographer.tar.gz -C /
source /opt/cartographer/setup.bash

cd $DIR
# Download the 2D backpack example bag.
wget --quiet https://storage.googleapis.com/cartographer-public-data/bags/backpack_2d/cartographer_paper_deutsches_museum.bag

# run cartographer
./xvfb.py `pwd`/record-cartographer_2d.sh

