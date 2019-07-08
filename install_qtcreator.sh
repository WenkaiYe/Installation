#!/bin/bash

sudo apt-get install build-essential
cd ~/Downloads
wget http://download.qt.io/official_releases/qt/5.9/5.9.1/qt-opensource-linux-x64-5.9.1.run
sudo chmod +x qt-opensource-linux-x64-5.9.1.run
./qt-opensource-linux-x64-5.9.1.run

#update configs
cd -
sudo cp -rf files/applications/qt-creator.desktop /usr/share/applications/DigiaQt-qtcreator-community.desktop
sudo cp -rf files/Qt/dusk.xml /opt/Qt/Tools/QtCreator/share/qtcreator/styles
sudo cp -rf files/Qt/Monaco.ttf /opt/Qt/Tools/QtCreator/share/qtcreator/fonts
cp -rf files/Qt/QtProject ~/.config/
sudo update-desktop-database
echo "alias qtcreator=/opt/Qt/Tools/QtCreator/bin/qtcreator" >> ~/.bashrc
source ~/.bashrc