#!/bin/bash

# start firmwared
sudo systemctl start firmwared

# launch sphinx
sphinx /opt/parrot-sphinx/usr/share/sphinx/drones/bebop2.drone::low_gpu=true::with_front_cam=false

# stop firmwared since it may raise plenty of system errors
echo disable firmwared
sudo systemctl stop firmwared
sudo systemctl disable firmwared
