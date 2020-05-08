# 河南大学卢福浩课题组软件安装脚本

为进一步简化Linux软件编译及安装方法，特设立此GitHub仓库

一般只需要直接运行程序，即可成功编译安装所需要的生物信息学软件

---

# 准备工作

在你的~/.bashrc里面添加如下行

export PROGPATH=${HOME}/Programs

export BIODATABASES=${HOME}/Databases

    其中，${HOME}/Programs为软件安装位置，可自行更改，此仓库的脚本都会默认安装到此目录下

    ${HOME}/Databases为数据库位置，可自行更改，数据库会安装到此位置

---

# 新软件的安装/编译问题

请到Issue下面提出问题

---

# Routine libraries

sudo apt-get install autoconf automake curl gcc libbz2-dev libcurl4-gnutls-dev liblzma-dev libncurses5-dev libncurses5-dev libssl-dev libtbb-dev make perl python3-dev zlib1g-dev

perl -MCPAN -e 'force install BioPerl'

perl -MCPAN -e 'install Bio::DB::Sam'

> need samtools compiled using fPic

perl -MCPAN -e 'install Cwd'

perl -MCPAN -e 'install Data::Dumper'

perl -MCPAN -e 'install File::Copy'

perl -MCPAN -e 'install File::Which'

perl -MCPAN -e 'install Scalar::Util'

perl -MCPAN -e 'install Statistics::Basic'

perl -MCPAN -e 'install Storable'


## Bowtie

> libtbb-dev

## FuhaoPerl5Lib

### https://github.com/lufuhao/FuhaoPerl5Lib

> Perl: BioPerl,Bio::DB::Sam,Cwd,Data::Dumper,File::Copy,File::Which,Scalar::Util,Statistics::Basic,Storable

> samtools

> seqtk

> CDBtools

## GMAP/GSNAP

> zlib, bzip2

## samtools

> zlib, GNU ncurses, HTSlib

## Trim_galore

> python3-dev 

## Trimmomatic

> JavaSE

---

## Author:
    Fu-Hao Lu

    Professor, PhD

    State Key Labortory of Crop Stress Adaptation and Improvement

    College of Life Science

    Jinming Campus, Henan University

    Kaifeng 475004, P.R.China

    E-mail: lufuhao@henu.edu.cn
