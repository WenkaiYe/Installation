#!/bin/bash

# do something here
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install libuuid1 libldap-2.4-2 libboost-program-options1.58.0 libboost-regex1.58.0 libboost-thread1.58.0 libgif7 libcdt5 libcgraph6 libpathplan4 libgvc6 libgvpr2 graphviz uuid-dev libldap2-dev libboost1.58-dev libboost1.58-tools-dev libboost-atomic1.58.0 libboost-atomic1.58-dev libboost-chrono1.58.0 libboost-chrono1.58-dev libboost-context1.58.0   libboost-context1.58-dev libboost-coroutine1.58.0 libboost-coroutine1.58-dev libboost-serialization1.58.0 libboost-serialization1.58-dev libboost-date-time1.58-dev libboost-exception1.58-dev libboost-system1.58-dev libboost-filesystem1.58-dev libboost-graph1.58.0 libboost-test1.58.0 libboost-test1.58-dev libboost-graph1.58-dev   libboost-mpi1.58.0 libboost-graph-parallel1.58.0 libboost-graph-parallel1.58-dev libboost-regex1.58-dev libboost-iostreams1.58-dev libboost-locale1.58.0 libboost-locale1.58-dev libboost-log1.58.0 libboost-thread1.58-dev libboost-log1.58-dev libboost-math1.58.0 libboost-math1.58-dev libboost-mpi1.58-dev libboost-python1.58.0 libboost-mpi-python1.58.0 libboost-mpi-python1.58-dev libboost-program-options1.58-dev libboost-python1.58-dev libboost-random1.58.0 libboost-random1.58-dev libboost-signals1.58.0 libboost-signals1.58-dev libboost-timer1.58.0 libboost-timer1.58-dev libboost-wave1.58.0 libboost-wave1.58-dev libgif-dev libwacom2 libwacom-common libinput-bin libinput10 libinput-dev libqt5clucene5 libqt5designer5 libqt5designercomponents5 libqt5help5 qttools5-dev qttools5-private-dev qttools5-dev-tools libwacom-bin libwxbase3.0-0v5 libwxgtk3.0-0v5 libyaml-cpp0.5v5 libyaml-cpp-dev python-tk python-wadllib python-launchpadlib -y --allow-unauthenticated
sudo apt-get install ros-kinetic-desktop-full -y
sudo rosdep init -y
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
sudo apt install libjs-sphinxdoc python-pyparsing -y --allow-unauthenticated
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install python-catkin-tools -y

rm -rf ~/catkin_ws
mkdir -p ~/catkin_ws/src
# cd ~/catkin_ws/src
# catkin_init_workspace
cd ~/catkin_ws
# catkin_make
catkin init
catkin build

rm -rf ~/rosbuild_ws
mkdir -p ~/rosbuild_ws/package_dir
cd ~/rosbuild_ws
rosws init . ~/catkin_ws/devel
rosws set ~/rosbuild_ws/package_dir -y

echo "source ~/rosbuild_ws/setup.bash" >> ~/.bashrc
source ~/.bashrc

# subl ~/rosbuild_ws/.rosinstall
echo "- setup-file: {local-name: /home/wye/catkin_ws/devel/setup.bash}" >> ~/rosbuild_ws/.rosinstall

echo $ROS_PACKAGE_PATH

# - other: {local-name: sandbox}