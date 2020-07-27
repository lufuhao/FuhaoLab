#!/bin/bash

sudo apt-get install alacarte cabextract chromium-browser filezilla flashplugin-installer gimp openmpi-bin stacer



### barrier
sudo apt-get install git cmake make xorg-dev g++ libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev libqt4-dev qtbase5-dev
# Disable system problem report
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport



###GIMP
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update
sudo apt-get install gimp



###Gparted
sudo apt-get install gparted



#InkScape
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt-get install inkscape



### PDF
#Linux PDF editor
sudo apt-get install pdfedit
#Scribus
sudo apt-get install scribus
#Flpsed
sudo apt-get install flpsed



## git
### Accelerate git clone
### 在网站  https://www.ipaddress.com/ 分别搜索
#140.82.112.3 github.com
#185.199.110.153 assets-cdn.github.com
#199.232.69.194 github.global.ssl.fastly.net
sudo vi /etc/hosts
#在hosts文件末尾添加两行
#199.232.69.194  github.global.ssl.fastly.Net
#140.82.112.3 github.com
#sudo /etc/init.d/networking restart
#Windows: ipconfig /flushdns
75.126.124.162 github.global.ssl.fastly.Net
13.250.177.223 github.com
185.199.110.153 assets-cdn.github.com
###JDK
###命令行方式安装oracle Java JDK
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
#sudo apt-get install oracle-java7-installer
sudo apt-get install oracle-java8-installer
###OR
###set oracle jdk environment
#export JAVA_HOME=
#export JRE_HOME=${JAVA_HOME}/jre
#export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
#export PATH=${JAVA_HOME}/bin:$PATH
#sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_60/bin/java 300
#sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_60/bin/javac 300
#sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0_60/bin/jar 300
#sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/jdk1.7.0_60/bin/javah 300
#sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.7.0_60/bin/javap 300

### QQ for Linux
### Linux QQ
#https://im.qq.com/linuxqq/download.html


### R
# ubuntu 20 R 4
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
sudo apt update
sudo apt install r-base
# ubuntu 18.04
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
#sudo apt-get update
#sudo apt-get install r-base

### Sougou input
sudo apt -y install fcitx fcitx-bin fcitx-table fcitx-table-all
sudo apt-get --fix-broken install
# 安装fcitx可视化的配置界面，不要安装“fcitx-qimpanel-configtool”
sudo apt -y install fcitx-config-gtk
#搜狗输入法 for linux：https://pinyin.sogou.com/linux/?r=pinyin
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
#首先，更改默认的输入法框架:通过“系统设置”》“区域和语言”》“管理已安装的语言”项,进入“语言支持”界面，进行输入法框架的配置,然后，重启系统。一定是“重启系统”，而不是“注销用户”。
#Fcitx配置: “全局配置”栏，用于进行快捷键、默认激活状态、窗口共享状态、候选词面板的配置。
#重启系统


### Ubuntu share
sudo apt-get install libapache2-mod-dnssd  gnome-user-share

###uget & aria2
#sudo apt update
#sudo apt install uget aria2
#FDM
sudo dpkg -i freedownloadmanager.deb
sudo apt install -f


### unity-tweak-tool
sudo apt-get install unity-tweak-tool notify-osd


sudo apt-get install ubuntu-restricted-extras

