#!/bin/bash
INSTALL_OPENCV_3=true
INSTALL_OPENCV_2=false

INSTALL_OPENCV3_PATH=/opt/opencv3
INSTALL_OPENCV2_PATH=/opt/opencv2
SDK_CONTRIB_PATH=opencv_contrib-3.4.1/modules

if ${INSTALL_OPENCV_3}
then	 	 
	sudo apt-get install build-essential libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg.dev libtiff4.dev libswscale-dev libjasper-dev -y

	# Remove any previous installations of x264</h3>
	sudo apt-get remove x264 libx264-dev -y
	 
	# We will Install dependencies now
	 
	sudo apt-get install build-essential checkinstall cmake pkg-config yasm -y
	sudo apt-get install git gfortran -y
	sudo apt-get install libjpeg8-dev libjasper-dev libpng12-dev -y
	 
	# If you are using Ubuntu 14.04
	# sudo apt-get install libtiff4-dev
	# If you are using Ubuntu 16.04
	sudo apt-get install libtiff5-dev -y
	 
	sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev -y
	sudo apt-get install libxine2-dev libv4l-dev -y
	sudo apt-get install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev -y
	sudo apt-get install qt5-default libgtk2.0-dev libtbb-dev -y
	sudo apt-get install libatlas-base-dev -y
	sudo apt-get install libfaac-dev libmp3lame-dev libtheora-dev -y
	sudo apt-get install libvorbis-dev libxvidcore-dev -y
	sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev -y
	sudo apt-get install x264 v4l-utils -y
	 
	# # Optional dependencies
	# sudo apt-get install libprotobuf-dev protobuf-compiler
	# sudo apt-get install libgoogle-glog-dev libgflags-dev
	# sudo apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

	sudo apt-get install cmake libeigen3-dev libsuitesparse-dev libqt4-dev qt4-qmake libqglviewer-dev -y

	# build opencv3
	sudo apt-get install libgoogle-glog-dev libgflags-dev -y
	cd SDK/opencv-3.4.1
	mkdir build
	cd build
	sudo rm -rf *
	cmake .. -DOPENCV_EXTRA_MODULES_PATH:PATH="../${SDK_CONTRIB_PATH}" -DCMAKE_INSTALL_PREFIX:PATH="${INSTALL_OPENCV3_PATH}" -DWITH_OPENMP:BOOL="1" -DWITH_CUFFT:BOOL="0" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_CUDA:BOOL="1" -DBUILD_TBB:BOOL="1" -DWITH_TBB:BOOL="1" -DWITH_CUBLAS:BOOL="0" -DOPENCV_ENABLE_NONFREE:BOOL="1"
	make -j
	sudo make install

	cd ..
	sudo rm -rf build
	sudo cp "${INSTALL_OPENCV3_PATH}/lib/pkgconfig/opencv.pc" "/usr/share/pkgconfig/opencv3.pc"
	# sudo ldconfig -v  
	cd ../../
fi

if ${INSTALL_OPENCV_2}
then
	# build opencv2
	cd SDK/opencv-2.4.13.6
	mkdir build
	cd build
	sudo rm -rf *
	cmake .. -DCMAKE_INSTALL_PREFIX:PATH="${INSTALL_OPENCV2_PATH}" -DBUILD_TBB:BOOL="1" -DWITH_CUFFT:BOOL="0" -DWITH_TBB:BOOL="1" -DWITH_CUDA:BOOL="1" -DCUDA_HOST_COMPILATION_CPP:BOOL="1" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_OPENMP:BOOL="1" -DCUDA_PROPAGATE_HOST_FLAGS:BOOL="1" -DCUDA_64_BIT_DEVICE_CODE:BOOL="1" -DCUDA_ATTACH_VS_BUILD_RULE_TO_CUDA_FILE:BOOL="1" -DBUILD_opencv_gpu:BOOL="1" 
	make -j
	sudo make install

	cd ..
	sudo rm -rf build

	sudo cp "${INSTALL_OPENCV2_PATH}/lib/pkgconfig/opencv.pc" "/usr/share/pkgconfig/opencv2.pc"
	# sudo ldconfig -v  
	cd ../../
fi

sudo ldconfig