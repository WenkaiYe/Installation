#!/bin/bash
#======================================================
#               Setup Flags Here
INSTALL_ROS_KINECT=true
INSTALL_ORBSLAM=true

INSTALL_OPENCV_2=false
INSTALL_OPENCV_3=false
#======================================================

# #reset superuser password
# sudo passwd

# #terminator
# sudo apt-get update
# sudo apt-get install terminator -y
# mkdir ~/.config/terminator
# cp files/config ~/.config/terminator/

# #sublime
# sudo apt-add-repository ppa:webupd8team/sublime-text-3 -y
# sudo apt-get update
# sudo apt-get install sublime-text-installer -y

# #chrome
# cd ~/Download
# sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
# wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install google-chrome-stable -y

# # install lapack
# sudo apt-get install liblapack-dev liblapacke liblapacke-dev libarpack2-dev -y
# sudo apt-get install gfortran libgfortran-4.8-dev -y
# # some other dependencies that could affect the performance
# sudo apt-get install libtiff4-dev libsuperlu3-dev libsuitesparse-dev freeglut3-dev
# sudo apt-get install libarmadillo4 libatlas-base-dev libatlas-dev libatlas3-base libignition-math2 libignition-math2-dev

# if ${INSTALL_ORBSLAM}
# then
# 	# OpenBLAS
# 	# wget https://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz
# 	cd SDK/OpenBLAS-0.2.20/
# 	make USE_THREAD=0 
# 	sudo make PREFIX=/opt/OpenBLAS install

# 	# build armadillo
# 	# sudo wget https://sourceforge.mirrorservice.org/a/ar/arma/armadillo-8.400.0.tar.xz
# 	cd ../armadillo-8.400.0
# 	mkdir build
# 	cd build
# 	cmake .. -DCMAKE_INSTALL_PREFIX:PATH="/opt/armadillo" -DCMAKE_INSTALL_LIBDIR:PATH="lib" -DCMAKE_BUILD_TYPE:STRING="Release" -Dopenblas_LIBRARY:FILEPATH="/opt/OpenBLAS/lib/libopenblas.so" -Dopenblasp_LIBRARY:FILEPATH="/opt/OpenBLAS/lib/libopenblas.so" -Dopenblaso_LIBRARY:FILEPATH="/opt/OpenBLAS/lib/libopenblas.so" -DLAPACK_LIBRARY:FILEPATH="/opt/OpenBLAS/lib/libopenblas.so"
# 	make -j
# 	sudo make install

# 	INSTALL_OPENCV_3=true
# 	cd ../../
# fi

#opencv2
# # build opencv2
# https://github.com/opencv/opencv/archive/2.4.13.6.zip
# cd /mnt/DATA/SDK/opencv-2.4.13.6
# mkdir build
# cd build
# cmake .. -DCMAKE_INSTALL_PREFIX:PATH="/opt/opencv2.4.13.6" -DBUILD_TBB:BOOL="1" -DWITH_CUFFT:BOOL="0" -DWITH_TBB:BOOL="1" -DWITH_CUDA:BOOL="0" -DCUDA_HOST_COMPILATION_CPP:BOOL="0" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_OPENMP:BOOL="1" -DCUDA_PROPAGATE_HOST_FLAGS:BOOL="0" -DCUDA_64_BIT_DEVICE_CODE:BOOL="0" -DCUDA_ATTACH_VS_BUILD_RULE_TO_CUDA_FILE:BOOL="0" -DBUILD_opencv_gpu:BOOL="0" 
# make -j
# sudo make install

# #opencv3
# if ${INSTALL_OPENCV_3}
# 	sudo apt-get install cmake libeigen3-dev libsuitesparse-dev libqt4-dev qt4-qmake libqglviewer-dev -y
# 	then
# 	# build opencv3
# 	sudo apt-get install libgoogle-glog-dev libgflags-dev -y
# 	cd SDK/opencv-3.4.1
# 	mkdir build
# 	cd build
# 	cmake .. -DOPENCV_EXTRA_MODULES_PATH:PATH="/home/nvidia/SDK/opencv_contrib-3.4.1/modules" -DCMAKE_INSTALL_PREFIX:PATH="/opt/opencv3" -DWITH_OPENMP:BOOL="1" -DWITH_CUFFT:BOOL="0" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_CUDA:BOOL="0" -DBUILD_TBB:BOOL="1" -DWITH_TBB:BOOL="1" -DWITH_CUBLAS:BOOL="0" -DOPENCV_ENABLE_NONFREE:BOOL="1"
# 	make -j
# 	sudo make install
# fi

#ros kinect
if ${INSTALL_ROS_KINECT}
then
	# do something here
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
	sudo apt-get update
	sudo apt-get install ros-kinetic-desktop-full -y
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y

	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
	wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install python-catkin-tools

	mkdir -p ~/catkin_ws/src
	cd ~/catkin_ws/src
	catkin init
	cd ~/catkin_ws/
	catkin build

	mkdir ~/rosbuild_ws
	cd ~/rosbuild_ws
	rosws init . ~/catkin_ws/devel
	mkdir ~/rosbuild_ws/sandbox
	rosws set ~/rosbuild_ws/sandbox

	echo "source ~/rosbuild_ws/setup.bash" >> ~/.bashrc
	source ~/.bashrc

	echo $ROS_PACKAGE_PATH
	#subl ~/rosbuild_ws/.rosinstall
	# - setup-file: {local-name: /home/<user>/catkin_ws/devel/setup.sh}
	# - other: {local-name: sandbox}
if
