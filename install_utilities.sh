#!/bin/bash

sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator -y

# config
echo "force_color_prompt=yes" >> ~/.bashrc
source ~/.bashrc