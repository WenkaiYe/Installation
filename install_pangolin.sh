#!/bin/bash

# ##################### Dependencies #####################
# C++11 & OpenGL
sudo apt-get install build-essential libgl1-mesa-dev -y
sudo apt-get install freeglut3-dev -y
sudo apt-get install libglew-dev libsdl2-dev libsdl2-image-dev libglm-dev libfreetype6-dev -y
# Glew
sudo apt-get install libglew-dev -y
# CMake
sudo apt-get install cmake -y
# python
sudo apt-get install libpython2.7-dev -y
# FFMPEG 
sudo apt-get install ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev -y
# for reading still-image sequences
sudo apt-get install libjpeg-dev libpng12-dev libtiff5-dev libopenexr-dev -y



cd ~/Downloads

git clone https://github.com/stevenlovegrove/Pangolin.git

cd Pangolin
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="/opt/Pangolin" -DCMAKE_BUILD_TYPE:STRING="Release"
make -j
sudo make install
