#!/bin/bash

sudo wget  http://xrl.us/cpanm  --no-check-certificate -O /sbin/cpanm
#curl -L https://cpanmin.us | perl - --sudo App::cpanminus
#curl -L https://cpanmin.us | perl - App::cpanminus
#wget -O - https://cpanmin.us | perl - App::cpanminus
#sudo wget https://cpanmin.us -O /sbin/cpanm
sudo chmod +x  /sbin/cpanm
echo "### cpanm" >> ${HOME}/.bashrc
echo "alias cpanm='cpanm --sudo --mirror http://mirrors.163.com/cpan --mirror-only'" >> ${HOME}/.bashrc
sudo cpanm App::pmuninstall
