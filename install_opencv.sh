#!/bin/bash
INSTALL_OPENCV_3=true
INSTALL_OPENCV_2=true

INSTALL_OPENCV3_PATH=/opt/opencv3
INSTALL_OPENCV2_PATH=/opt/opencv2
# SDK_CONTRIB_PATH_PREFIX=/media/wye/DATA/backup/setup_device/setup_new_device/SDK/opencv-3.4.1/opencv_contrib-3.4.1/modules
SDK_CONTRIB_PATH=SDK/opencv_contrib-3.4.1/modules

if ${INSTALL_OPENCV_3}
then	 	 
	# download SDK
	mkdir SDK
	wget https://codeload.github.com/opencv/opencv/zip/3.4.1 -P SDK
	unzip SDK/3.4.1 -d SDK

	wget https://codeload.github.com/opencv/opencv_contrib/zip/3.4.1 -O SDK/opencv-3.4.1/3.4.1_contrib
	unzip SDK/3.4.1_contrib -d SDK

	sudo rm -rf $INSTALL_OPENCV3_PATH

	sudo apt-get install libgtk2.0-bin libgail-common libgail18 libgtk2.0-doc libgtk2.0-dev libgtk2.0-0 gir1.2-gtk-2.0 python-dev python-minimal python libpython-dev libpython-stdlib cmake cmake-data libdrm-common libdrm2 libdrm-amdgpu1 libdrm-intel1 libdrm-radeon1 libdrm-nouveau2 libdrm-dev libwayland-egl1-mesa libegl1-mesa libgbm1 libllvm6.0 libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa libegl1-mesa-dev libgles2-mesa libgles2-mesa-dev mesa-common-dev libgl1-mesa-dev -y --allow-unauthenticated

	sudo apt-get install build-essential libjpeg.dev libtiff4.dev libswscale-dev libjasper-dev -y

	# Remove any previous installations of x264</h3>
	sudo apt-get remove x264 libx264-dev libgl-dev -y
	 
	# We will Install dependencies now
	 
	sudo apt-get install checkinstall pkg-config yasm -y
	sudo apt-get install git gfortran libqt5opengl5-dev -y
	sudo apt-get install libjpeg8-dev libpng12-dev -y

	sudo apt-get install python-numpy libpng-dev libtiff-dev libtbb2 -y
	 
	# If you are using Ubuntu 14.04
	# sudo apt-get install libtiff4-dev
	# If you are using Ubuntu 16.04
	sudo apt-get install libtiff5-dev qtbase5-dev -y
	 
	sudo apt-get install libavcodec-dev libavformat-dev libdc1394-22-dev -y
	sudo apt-get install libxine2-dev libv4l-dev -y
	sudo apt-get install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev -y
	sudo apt-get install qt5-default libtbb-dev -y
	sudo apt-get install libatlas-base-dev -y
	sudo apt-get install libfaac-dev libmp3lame-dev libtheora-dev -y
	sudo apt-get install libvorbis-dev libxvidcore-dev -y
	sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev -y
	sudo apt-get install x264 v4l-utils -y
	 
	# # Optional dependencies
	# sudo apt-get install libprotobuf-dev protobuf-compiler
	# sudo apt-get install libgoogle-glog-dev libgflags-dev
	# sudo apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

	sudo apt-get install libeigen3-dev libsuitesparse-dev libqt4-dev qt4-qmake libqglviewer-dev -y

	# build opencv3
	sudo apt-get install libgoogle-glog-dev libgflags-dev -y
	cd SDK/opencv-3.4.1
	sudo rm -rf build
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_OPENCV3_PATH} -DBUILD_TBB:BOOL="1" -DWITH_TBB:BOOL="1" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_OPENMP:BOOL="1"  -DBUILD_opencv_gpu:BOOL="0" -DOPENCV_EXTRA_MODULES_PATH:PATH=${SDK_CONTRIB_PATH} -DBUILD_opencv_cudaobjdetect:BOOL="0" -DWITH_CUFFT:BOOL="0" -DBUILD_opencv_cudaimgproc:BOOL="0" -DBUILD_opencv_cudastereo:BOOL="0" -DBUILD_opencv_cudaoptflow:BOOL="0" -DBUILD_opencv_cudabgsegm:BOOL="0" -DBUILD_opencv_cudaarithm:BOOL="0" -DWITH_CUDA:BOOL="0" -DOPENCV_ENABLE_NONFREE:BOOL="1" -DBUILD_opencv_cudacodec:BOOL="0" -DWITH_CUBLAS:BOOL="0" -DBUILD_opencv_cudawarping:BOOL="0" -DBUILD_opencv_cudafilters:BOOL="0" -DCUDA_64_BIT_DEVICE_CODE:BOOL="0" -DBUILD_opencv_cudafeatures2d:BOOL="0" -DBUILD_opencv_cudalegacy:BOOL="0" 
	make -j
	sudo make install

	cd ..
	sudo cp "${INSTALL_OPENCV3_PATH}/lib/pkgconfig/opencv.pc" "/usr/share/pkgconfig/opencv3.pc"
	# sudo ldconfig -v  
	cd ../../
fi

if ${INSTALL_OPENCV_2}
then
	# download SDK
	mkdir SDK
	cd SDK
	wget https://codeload.github.com/opencv/opencv/zip/2.4.13.6
	unzip 2.4.13.6 -d SDK

	sudo rm -rf $INSTALL_OPENCV2_PATH

	# build opencv2
	cd SDK/opencv-2.4.13.6
	mkdir build
	cd build
	sudo rm -rf *
	cmake .. -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_OPENCV2_PATH} -DBUILD_TBB:BOOL="1" -DWITH_CUFFT:BOOL="0" -DWITH_TBB:BOOL="1" -DWITH_CUDA:BOOL="0" -DCUDA_HOST_COMPILATION_CPP:BOOL="0" -DCMAKE_BUILD_TYPE:STRING="Release" -DWITH_OPENMP:BOOL="1" -DCUDA_PROPAGATE_HOST_FLAGS:BOOL="0" -DCUDA_64_BIT_DEVICE_CODE:BOOL="0" -DCUDA_ATTACH_VS_BUILD_RULE_TO_CUDA_FILE:BOOL="0" -DBUILD_opencv_gpu:BOOL="0" 
	make -j
	sudo make install

	cd ..
	sudo rm -rf build

	sudo cp "${INSTALL_OPENCV2_PATH}/lib/pkgconfig/opencv.pc" "/usr/share/pkgconfig/opencv2.pc"
	# sudo ldconfig -v  
	cd ../../
fi

sudo ldconfig
