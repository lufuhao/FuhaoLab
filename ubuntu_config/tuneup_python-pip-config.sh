#!/bin/bash

###pip
#sudo apt-get install python-pip
mkdir ~/.pip
echo -e "[global]" >> ~/.pip/pip.conf
echo "index-url=https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf
echo -e "[install]" >> ~/.pip/pip.conf
echo -e "trusted-host=mirrors.aliyun.com" >> ~/.pip/pip.conf
echo -e "timeout = 150" >> ~/.pip/pip.conf
echo -e "# 超时时间设置(单位为s)，一般可以设置的长一些" >> ~/.pip/pip.conf


###update all python modules using pip
#sudo pip install -U $(pip freeze | cut -d '=' -f 1)

