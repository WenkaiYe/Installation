#!/bin/bash
cd tmp

sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator -y

# config
echo "force_color_prompt=yes" >> ~/.bashrc
source ~/.bashrc


# ccache
sudo apt-get update
sudo apt-get install ccache -y


# anydesktop
sudo apt-get install libgtkglext1 libgdal-dev libpng-dev -y
wget https://download.anydesk.com/linux/anydesk-5.1.1-amd64.tar.gz -P tmp
tar -xzf tmp/anydesk-5.1.1-amd64.tar.gz 
sudo mv anydesk-5.1.1 /opt/anydesk
echo "alias anydesk=/opt/anydesk/anydesk" >> ~/.bashrc
source ~/.bashrc

# # sogou
# wget http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb
# sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
# sudo apt-get install -f -y
# sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb

# google pinyin
sudo apt-get install fcitx-googlepinyin -y
