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

# Requirements

## Routine libraries

sudo apt-get install alacarte arj autoconf automake build-essential cabextract chromium-browser cmake convmv curl cython3 fig2dev file-roller filezilla flashplugin-installer g++ gcc gedit-plugins gimp git-all gnuplot libboost-dev libboost-all-dev libbz2-dev libcurl4-gnutls-dev libcurl4-openssl-dev libexpat1-dev libgd-dev libglu1-mesa-dev libjsoncpp-dev liblzma-dev libncurses5-dev libopenmpi-dev libpng-dev qt5-default libreadline-dev libsqlite3-dev libssl-dev libtbb-dev libterm-readline-gnu-perl libxml-dom-xpath-perl make mesa-common-dev mpack openmpi-bin perl p7zip-full p7zip-rar python-pip python3-dev python3-pip python-setuptools python3-setuptools qtcreator rar sharutils sqlite3 subversion tcsh texlive-extra-utils unace unrar unzip uudeview xfig yaggo zip zlib1g zlib1g-dev



## Python modules

sudo pip3 install cython

## Perl modules

perl -MCPAN -e 'force install BioPerl'

perl -MCPAN -e 'install Bio::DB::Sam'

> need samtools compiled using fPic

perl -MCPAN -e 'install Cwd'

perl -MCPAN -e 'install Data::Dumper'

perl -MCPAN -e 'install File::Copy'

perl -MCPAN -e 'install File::Which'

perl -MCPAN -e 'install FindBin'

perl -MCPAN -e 'install Scalar::Util'

perl -MCPAN -e 'install Statistics::Basic'

perl -MCPAN -e 'install Storable'

---

# Softwares

## [bamaddrg](https://github.com/lufuhao/bamaddrg)

> BamTools, g++

## [BamTools]

> Cmake (version >= 3.0) JsonCpp >= 1.8.0, make

## [Bowtie](https://github.com/BenLangmead/bowtie)

> libtbb-dev

## [CutAdapt](https://github.com/marcelm/cutadapt)

> Python modules: python-pip python3-pip python-setuptools python3-setuptools

## [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc)

> Perl modules: FindBin, Getopt::Long

## [FuhaoPerl5Lib](https://github.com/lufuhao/FuhaoPerl5Lib)

> Perl: BioPerl,Bio::DB::Sam,Cwd,Data::Dumper,File::Copy,File::Which,Scalar::Util,Statistics::Basic,Storable

> samtools,seqtk,CDBtools

## [HANDS2](https://genomics.lums.edu.pk/software/hands2/)

> JavaSE

## [HTSlib](https://github.com/samtools/htslib)

> zlib, autoconf, make

## [GMAP/GSNAP](http://research-pub.gene.com/gmap/)

> zlib, bzip2

## [GNUplot](http://www.gnuplot.info/)

> texdir, GD, libreadline-dev

## [Jellyfish](https://github.com/gmarcais/Jellyfish)

> autoreconf, gcc, make

## MACS2(https://github.com/taoliu/MACS)

> Gcc 5.2.0; Numpy_ (>=1.6); Cython_ (>=0.18)

## MUMmer

### [MUMmer4](http://mummer4.github.io)

> g++ version >= 4.7, GNU make, ar, perl >=5.6.0, sh, sed, awk, tcsh

>> sudo apt-get build-essential

> fig2dev (3.2.3)

> gnuplot (4.0)

> xfig (3.2)

> yaggo

## [picard](https://github.com/broadinstitute/picard)

> JavaSE

## [Primer3](https://github.com/primer3-org/primer3)

> build-essential g++ cmake git-all

## [samtools](https://github.com/samtools/samtools)

> zlib, GNU ncurses, HTSlib

> inst_samtools-v0.1.20.fPIC.sh is only for Bio::DB::Sam installation

## [Trim_galore](https://github.com/FelixKrueger/TrimGalore)

> python3-dev 

## [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)

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
