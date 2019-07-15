#!/bin/bash
DEPENDENCIES_DIR=SDK
PANGOLIN_INSTALL_PATH=/opt/Pangolin
OPENBLAS_INSTALL_PATH=/opt/OpenBLAS
ARMADILLO_INSTALL_PATH=/opt/armadillo

# clean space
sudo rm -rf $PANGOLIN_INSTALL_PATH
sudo rm -rf $OPENBLAS_INSTALL_PATH
sudo rm -rf $ARMADILLO_INSTALL_PATH

# build Pangolin
sudo apt-get install libglew-dev
cd ${DEPENDENCIES_DIR}
wget https://github.com/stevenlovegrove/Pangolin/archive/v0.5.tar.gz
rm -rf cd ${DEPENDENCIES_DIR}/Pangolin-0.5/
tar xf v0.5.tar.gz
cd ${DEPENDENCIES_DIR}/Pangolin-0.5/
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$PANGOLIN_INSTALL_PATH -DCMAKE_BUILD_TYPE:STRING="Release"
make -j
sudo make install
cd ${DEPENDENCIES_DIR}
rm -rf ${DEPENDENCIES_DIR}/Pangolin-0.5

# build openblas with single-thread
cd ${DEPENDENCIES_DIR}
wget https://sourceforge.net/projects/openblas/files/v0.3.5/OpenBLAS%200.3.5%20version.zip
rm -rf cd ${DEPENDENCIES_DIR}/xianyi-OpenBLAS-eebc189/
unzip OpenBLAS\ 0.3.5\ version.zip
cd ${DEPENDENCIES_DIR}/xianyi-OpenBLAS-eebc189/
make USE_THREAD=0 
sudo make PREFIX=$OPENBLAS_INSTALL_PATH install
cd ${DEPENDENCIES_DIR}
rm -rf ${DEPENDENCIES_DIR}/xianyi-OpenBLAS-eebc189

# build armadillo
cd ${DEPENDENCIES_DIR}
wget https://sourceforge.net/projects/arma/files/armadillo-9.200.7.tar.xz
rm -rf cd ${DEPENDENCIES_DIR}/armadillo-9.200.7/
tar xf armadillo-9.200.7.tar.xz
cd ${DEPENDENCIES_DIR}/armadillo-9.200.7/
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$ARMADILLO_INSTALL_PATH -DCMAKE_INSTALL_LIBDIR:PATH="lib" -DCMAKE_BUILD_TYPE:STRING="Release" -Dopenblas_LIBRARY:FILEPATH="${OPENBLAS_INSTALL_PATH}/lib/libopenblas.so" -Dopenblasp_LIBRARY:FILEPATH="${OPENBLAS_INSTALL_PATH}/lib/libopenblas.so" -Dopenblaso_LIBRARY:FILEPATH="${OPENBLAS_INSTALL_PATH}/lib/libopenblas.so" -DLAPACK_LIBRARY:FILEPATH="${OPENBLAS_INSTALL_PATH}/lib/libopenblas.so" 
make -j
sudo make install
cd ${DEPENDENCIES_DIR}
rm -rf ${DEPENDENCIES_DIR}/armadillo-9.200.7