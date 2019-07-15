#!/bin/bash
cd tmp
wget https://us.download.nvidia.cn/XFree86/Linux-x86_64/384.90/NVIDIA-Linux-x86_64-384.90.run

sudo touch blacklist-nouveau.conf  
sudo echo "blacklist nouveau" >> blacklist-nouveau.conf
sudo echo "options nouveau modeset=0" >> blacklist-nouveau.conf
sudo mv -f blacklist-nouveau.conf /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u  

sudo service lightdm stop
sudo chmod a+x NVIDIA-Linux-x86_64-384.90.run
sudo sh NVIDIA-Linux-x86_64-384.90.run --no-x-check --no-nouveau-check --no-opengl-files
sudo service lightdm start


wget https://developer.download.nvidia.cn/compute/cuda/9.0/secure/Prod/local_installers/cuda_9.0.176_384.81_linux.run
sudo sh cuda_9.0.176_384.81_linux.run 
