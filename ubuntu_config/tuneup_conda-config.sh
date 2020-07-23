#!/bin/bash



# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
# https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/ 
#wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
#bash Miniconda3-latest-Linux-x86_64.sh
#source ~/.bashrc 
## 安装好conda后需要设置镜像
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda
#conda config --set show_channel_urls yes


###conda
echo "channels:" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/" >> ~/.condarc
echo "  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/" >> ~/.condarc
echo "  - defaults" >> ~/.condarc
echo "show_channel_urls: true" >> ~/.condarc




