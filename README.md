# 河南大学卢福浩课题组软件安装脚本

为进一步简化Linux软件编译及安装方法，特设立此GitHub仓库

一般只需要直接运行程序，即可成功编译安装所需要的生物信息学软件

---

# 准备工作

Check out your machtype and set up your MACHTYPE variable

```

uname -m

```
在你的~/.bashrc里面添加如下行

```

export PROGPATH=${HOME}/Programs

export BIODATABASES=${HOME}/Databases

export MACHTYPE=x86_64

export MODULEPATH=${PROGPATH}/bin/modules:$MODULEPATH

#其中，${HOME}/Programs为软件安装位置，可自行更改，此仓库的脚本都会默认安装到此目录下

#${HOME}/Databases为数据库位置，可自行更改，数据库会安装到此位置

export FUHAOLAB_ROOT=/path/to/FuhaoLab

export PATH=${FUHAOLAB_ROOT}/bin:${FUHAOLAB_ROOT}/ubuntu_config:$PROGPATH/bin:$PATH

```

Then create the folders required

```

mkdir -p $PROGPATH $BIODATABASES ${PROGPATH}/bin/modules

```

---

# 新软件的安装/编译问题

Raise a hand in this repository Issue if you have any problem, question or if you want some scripts for new softwares.

---

# Requirements

## Routine libraries

```
sudo apt-get install alacarte arj autoconf automake build-essential cabextract chromium-browser cmake convmv curl cython3 fig2dev file-roller filezilla flashplugin-installer g++ gcc gedit-plugins gimp git-all gnuplot libboost-dev libboost-all-dev libbz2-dev libcurl4-gnutls-dev libexpat1-dev libgd-dev libgd3 libglu1-mesa-dev libhdf5-dev libhpdf-dev libjemalloc-dev libjsoncpp-dev liblzma-dev libncurses5-dev libopenmpi-dev libpng-dev qt5-default libreadline-dev libsparsehash-dev libsqlite3-dev libssl-dev libtbb-dev libterm-readline-gnu-perl libtool libxml-dom-xpath-perl make mesa-common-dev mpack openmpi-bin perl p7zip-full p7zip-rar pigz python3-dev python3-pip python-setuptools python3-matplotlib python3-scipy python3-setuptools python3-tabulate qtcreator rar sharutils sqlite3 subversion tcsh texlive-extra-utils texlive-latex-extra unace unrar unzip uudeview xfig yaggo zip zlib1g zlib1g-dev zsh zsh-common

# libcurl4-openssl-dev python-pip

sudo apt-get install openmpi-bin openmpi-common openssh-client openssh-server libopenmpi3 libopenmpi-dev
```

## Python modules

```
sudo pip3 install cython biopython
```

## Perl modules

```
perl -MCPAN -e 'force install BioPerl'

#need samtools compiled using fPic
perl -MCPAN -e 'install Bio::DB::Sam'

perl -MCPAN -e'install($_) for qw( Carp Clone Config::General Data::Dumper Digest::MD5 File::Basename File::Copy File::Spec::Functions File::Temp File::Which FindBin Font::TTF::Font GD GD::Polyline Getopt::Long IO::File List::MoreUtils List::Util Log::Log4perl Math::Bezier Math::BigFloat Math::Round Math::VecStat Memoize POSIX Params::Validate Pod::Usage Readonly Regexp::Common SVG Set::IntSpan Statistics::Basic Storable Sys::Hostname Text::Balanced Text::Format Time::HiRes )'

```

---

# Softwares

## [ABySS](https://www.bcgsc.ca/resources/software/abyss) [github](https://github.com/bcgsc/abyss)

> boost, openmpi, sparsehash

```
sudo apt-get install libboost-dev libboost-all-dev openmpi-bin libsparsehash-dev
```

> [ARCS](https://github.com/bcgsc/arcs), [Tigmint](https://github.com/bcgsc/tigmint), [samtools](https://samtools.github.io/)

> [pigz](https://zlib.net/pigz/), [zsh](https://sourceforge.net/projects/zsh/)

```
sudo apt-get install pigz zsh zsh-common
```

## [ALLPATHS-LG]() doi: [10.1101/gr.141515.112](https://dx.doi.org/10.1101/gr.141515.112)

> [GCC](http://gcc.gnu.org/) v4.7.0+, [GMP](http://gmplib.org/) library compiled with the C++ interface, [Picard](http://picard.sourceforge.net/) set, command dot from the [graphviz](http://www.graphviz.org/) package.

```
sudo apt-get install libgmp-dev graphviz
```
## [Aspera-Connect](https://www.ibm.com/aspera/connect/)

> OpenSSL (>=v1.0.2g), Mesa EGL, glib2 (>=v2.28)

## [bamaddrg](https://github.com/lufuhao/bamaddrg)

> BamTools, g++

## [bambam](http://sourceforge.net/projects/bambam/)

> [SAMtools](https://github.com/samtools/samtools), [BAMtools](https://github.com/pezmaster31/bamtools)

> BioPerl

> Following files must be found in your LIBRARY_PATH variable: libbam.a, libhts.a, libbamtools.a, libbamtools-utils.a, libz.a

## [BamTools](https://github.com/pezmaster31/bamtools)

> Cmake (version >= 3.0) JsonCpp >= 1.8.0, make

## [Bandage](https://github.com/rrwick/Bandage)

> Qt5

```
sudo apt-get install build-essential git qtbase5-dev
```


## [BEDtools](https://github.com/arq5x/bedtools2)

>

## [BLASR](https://github.com/mchaisso/blasr)

> Require: HDF5 (HDF5INCLUDEDIR, HDF5LIBDIR)

## [Bowtie](https://github.com/BenLangmead/bowtie)

> libtbb-dev

## [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml), [GitHub]()

> libtbb-dev, zlib, Java　(for SRA support)

## [canu](https://github.com/marbl/canu)

> 16GB Mem; GCC 4.5; GCC 7+

> Perl 5.12.0, or File::Path 2.08

> Java SE 8

> gnuplot 5.2

## [CD-HIT](https://github.com/weizhongli/cdhit)

> zlib, openmpi

## [Circos](http://circos.ca)

> libgd-dev

> Perl modules: Carp, Clone, Config::General, Cwd, Data::Dumper, Digest::MD5, File::Basename, File::Spec::Functions, File::Temp, FindBin, Font::TTF::Font, GD, GD::Polyline, Getopt::Long, IO::File, List::MoreUtils, List::Util, Math::Bezier, Math::BigFloat, Math::Round, Math::VecStat, Memoize, POSIX, Params::Validate, Pod::Usage, Readonly, Regexp::Common, SVG, Set::IntSpan, Statistics::Basic, Storable, Sys::Hostname, Text::Balanced, Text::Format, Time::HiRes

```
circos -modules | grep "missing"

sudo apt-get install libgd-dev

perl -MCPAN -e'install($_) for qw( Carp Clone Config::General Data::Dumper Digest::MD5 File::Basename File::Spec::Functions File::Temp FindBin Font::TTF::Font GD GD::Polyline Getopt::Long IO::File List::MoreUtils List::Util Math::Bezier Math::BigFloat Math::Round Math::VecStat Memoize POSIX Params::Validate Pod::Usage Readonly Regexp::Common SVG Set::IntSpan Statistics::Basic Storable Sys::Hostname Text::Balanced Text::Format Time::HiRes )'
```


## [CutAdapt](https://github.com/marcelm/cutadapt)

> Python modules: python-pip python3-pip python-setuptools python3-setuptools

## [deepTools](https://github.com/deeptools/deepTools)

> python

## Discovar [NotWorking]

### [DISCOVARdenovo](https://software.broadinstitute.org/software/discovar/blog/)

> 64 bit x86_64 based linux, GCC >= 4.7.0, jemalloc, samtools

```
apt-get install libjemalloc-dev
```

### [DISCOVARvariantcaller](https://software.broadinstitute.org/software/discovar/blog/)

> GCC >= 4.7.0

## [Eagle](https://github.com/tony-kuo/eagle)

> [HTSLIB](https://github.com/samtools/htslib)

## [EMBOSS](http://emboss.sourceforge.net/download)

> JDK (JAVA_HOME), libhpdf-dev, libpng-dev

```
sudo apt-get install libhpdf-dev libpng-dev
```

## [Falcon](https://github.com/PacificBiosciences/FALCON-integrate)

> Python2-dev, nim

## [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/download.html)

> Perl modules: FindBin, Getopt::Long

## [Flye](https://github.com/fenderglass/Flye/)

> Python 2.7 or 3.5+ with setuptools C++ compiler with C++11 support (GCC 4.8+)

> GNU make, Git, Core OS development headers (zlib, ...)

## [FuhaoPerl5Lib](https://github.com/lufuhao/FuhaoPerl5Lib)

> Perl: BioPerl,Bio::DB::Sam,Cwd,Data::Dumper,File::Copy,File::Which,Scalar::Util,Statistics::Basic,Storable

> samtools,seqtk,CDBtools

## [gffread](https://github.com/gpertea/gffread)

> [gclib](https://github.com/gpertea/gclib), make

## [GMAP/GSNAP](http://research-pub.gene.com/gmap/)

> zlib, bzip2

## [HISAT2](https://daehwankimlab.github.io/hisat2), [Github](https://github.com/DaehwanKimLab/hisat2)

> 

## [HMMER](https://github.com/EddyRivasLab/hmmer)

> [easel](https://github.com/EddyRivasLab/easel)

## [HTseq](https://htseq.readthedocs.io/en/master/), [GitHub](https://github.com/htseq/htseq)

> matplotlib, Cython, pysam, HTSeq

## [IOGA](https://github.com/holmrenser/IOGA) [NotWorking due to python2]

> Python2, BioPython, BBmap, SOAPdenovo2, SeqTK, SPAdes.py, ALE, Samtools 0.1.19, Picardtools

## [Jellyfish](https://github.com/gmarcais/Jellyfish)

> Requirements: autoconf automake, autoreconf gcc gettext libtool make pkg-config yaggo

## [KAT](https://github.com/TGAC/KAT)

> v4.8+, make, autoconf V2.53+, automake  V1.11+, libtool V2.4.2+, pthreads, zlib, Python V3.5+, Sphinx-doc V1.3+

```
sudo apt-get install autoconf automake libtool python3-matplotlib python3-scipy python3-tabulate
```

## [Kent](http://hgdownload.cse.ucsc.edu/admin/)

> MySQL uuid-dev

```
sudo apt install uuid-dev mysql-server
```

## [killisto](https://pachterlab.github.io/kallisto/download.html) [github](https://github.com/pachterlab/kallisto)

> cmake, zlib, HDF5 C libraries

```
sudo apt install cmake zlib1g-dev libhdf5-dev
```

> try to unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH

## [LAST](http://last.cbrc.jp/)

> g++; >2G memory

> if errors are reported in 'make', try to comment line20 and uncomment line21 or line22

## [LoRDEC](http://www.atgc-montpellier.fr/lordec/) doi: [10.1093/bioinformatics/btu538](https://dx.doi.org/10.1093/bioinformatics/btu538)

> gcc/g++ 4.8+, [GATB](https://github.com/GATB/gatb-core) (auto-download), libboost (auto-download), make, cmake, zlib1g-dev, wget

## [MACS2](https://github.com/taoliu/MACS)

> GCC 5.2.0; Numpy_ (>=1.6); Cython_ (>=0.18)

## [MaSuRCA](https://github.com/alekseyzimin/masurca)

> ubuntu 12+

> For Developers: [swig](http://www.swig.org/), [yaggo](https://github.com/gmarcais/yaggo)

## MCScanX: [Official](http://chibba.pgml.uga.edu/mcscan2/), [GitHub](https://github.com/wyp1125/MCScanx), [Updated GitHub](https://github.com/lufuhao/MCScanX)

> For Linux: JavaSE, libpng

> For Mac: Xcode

## [MECAT2](https://github.com/xiaochuanle/MECAT2)

> Included: HDF5, dextract

## [MEME](http://meme-suite.org/doc/download.html)

> Perl > 5.16, Python 2.7.x or 3.x, zlib, Ghostscript (for creating PNG files), Assorted common utilities

```
sudo apt-get install autoconf automake libtool zlib1g-dev
```

> Optional: MPI, libxml2, libxslt & libexslt

```
sudo apt-get install libxml2-dev libxslt1-dev openmpi-bin
```
> Web: Java Development Kit, Apache Ant, Apache Tomcat, Opal, Batch Scheduler

```
sudo apt-get install ant
```

## [MINIA](https://github.com/GATB/minia)

> [CMake](http://www.cmake.org/cmake/resources/software.html) 3.10+

> C++11 compiler; (g++ version>=4.7 (Linux), clang version>=4.3 (Mac OSX))

## [Minimap2](https://github.com/lh3/minimap2)

> Require: gcc-c++, make, zlib

## [MIRA](https://sourceforge.net/projects/mira-assembler) [MIRA5](https://github.com/bachev/mira)

> gcc v6.1+, gcc >= 6.1, with libstdc++6, Or clang >= 3.5, BOOST library >= 1.48 (? 1.61 on OSX), zlib, GNU make, GNU flex >= 2.6.0, Expat library >= 2.0.1, xxd

```
sudo apt-get install flex xxd
```

## [MITObim](https://github.com/chrishah/MITObim)

> GNU utilities, Perl

> [MIRA](https://sourceforge.net/projects/mira-assembler) 4.0.2+

## MUMmer

### [MUMmer4](http://mummer4.github.io)

> g++ version >= 4.7, GNU make, ar, perl >=5.6.0, sh, sed, awk, tcsh

```
sudo apt-get build-essential
```

> fig2dev (3.2.3), gnuplot (4.0), xfig (3.2), yaggo

## [NECAT](https://github.com/xiaochuanle/NECAT)

> GCC 4.8.5+, perl v5.26+

## [NextDenovo](https://github.com/Nextomics/NextDenovo)

> python mocules: [Psutil](https://psutil.readthedocs.io/en/latest/)

```
pip3 install --user Psutil
```

## [NLGenomeSweeper](https://github.com/ntoda03/NLGenomeSweeper)

>  Python >=3.5; blast+; MUSCLE aligner; SAMtools; bedtools; HMMER; InterProScan with PANTHER database; TransDecoder

## [NLR-Annotator](https://github.com/steuernb/NLR-Annotator)

> MEME, JRE > 1.6

>    MEME 5.1: ./inst_NLRannotator-latestGitHub-nlr_parser3.sh

>    MEME < 4.9.1: ./inst_NLRannotator-v0.7beta9281f70.sh

## [NOVOPlasty](https://github.com/ndierckx/NOVOPlasty)

> Perl

## [Phy-Mer](https://github.com/MEEIBioinformaticsCenter/phy-mer)

> Python2/3, Pysam (0.7.4 tested), BioPython (1.58 tested)

## polyCat (see bambam above)

> BioPerl, [BAMtools](https://github.com/pezmaster31/bamtools)

## polyDog (see bambam above)

> 

## [Primer3](https://github.com/primer3-org/primer3)

> build-essential g++ cmake git-all

## [proovread](https://github.com/BioInf-Wuerzburg/proovread) doi: [10.1093/bioinformatics/btu392](https://dx.doi.org/10.1093/bioinformatics/btu392)

> Perl 5.10.1+: Cwd Data::Dumper File::Basename File::Copy File::Path File::Spec File::Temp File::Which FindBin Getopt::Long List::Util Log::Log4perl Storable Thread::Queue threads Time::HiRes

> Blast-2.2.24+, samtools-1.1+

## [R](https://cloud.r-project.org/)

> 

## [Ray](https://github.com/sebhtml/ray)

> [RayPlatform](https://github.com/sebhtml/RayPlatform)

## [Sambamba](https://github.com/biod/sambamba)

> D compiler (ldc), BioD (git submodule), gcc tool chain (for htslib and lz4), htslib (git submodule), undeaD (git submodule), libz, liblz4

>    inst_lib_ldc-v1.22.0.sh

## [Salmon](https://combine-lab.github.io/salmon/)

> libbz2, liblzma, Boost, Cereal, libtbb, libcurl, PkgConfig, libgff, Jemalloc, libstadenio, pufferfish, zlib1g, 

> # Will automatically download libgff, Jemalloc, Cereal,libstadenio, pufferfish

```
sudo apt install libboost-dev libboost-all-dev libbz2-dev libcurl4-gnutls-dev liblzma-dev libtbb-dev zlib1g-dev 
```

## [samtools](https://github.com/samtools/samtools)

> zlib, GNU ncurses, [HTSlib](https://github.com/samtools/htslib)

> # inst_samtools-v0.1.20.fPIC.sh is only for Bio::DB::Sam installation

## [seqkit](https://github.com/shenwei356/seqkit) doi: [10.1371/journal.pone.0163962](https://dx.doi.org/10.1371/journal.pone.0163962)

> Go language

```
sudo apt-get install golang gox
```

## [seqtk](https://github.com/lh3/seqtk)

> make

## [SGA]()

> Requirements: google [sparsehash](https://github.com/sparsehash/sparsehash) library, [zlib](http://www.zlib.net/),  the [jemalloc](http://www.canonware.com/jemalloc/download.html) memory allocator

> Requirements: Python modules: pysam, [ruffus](http://www.ruffus.org.uk/)

```
apt-get install libsparsehash-dev libjemalloc-dev zlib1g-dev

pip3 install --user pysam ruffus
```

## [Smartdenovo](https://github.com/ruanjue/smartdenovo)

> Perl

## [SOAPdenovo2](https://github.com/aquaskyline/SOAPdenovo2) [NotWorking]

> make

## [SPAdes](https://github.com/ablab/spades)

> g++ v5.3.1+, cmake v3.5+, zlib, libbz2

> 64bit Linux, Python 2.7+

## [SpliceSeq](https://bioinformatics.mdanderson.org/public-software/spliceseq)

> JavaSE (64bit), bowtie, MySQL (v5.5.x+)

```bash
mysql -u root -p

mysql> CREATE DATABASE SpliceGraph CHARACTER SET latin1 COLLATE latin1_general_ci;

mysql> GRANT SELECT ON SpliceGraph.* TO 'sguser'@'localhost' IDENTIFIED BY 'sgpass';

mysql> GRANT SELECT ON SpliceGraph.* TO 'sguser'@'%' IDENTIFIED BY 'sgpass';

mysql>GRANT ALL ON SpliceGraph.* TO 'sgload'@'localhost' IDENTIFIED BY 'sg4ld!';

mysql>GRANT ALL ON SpliceGraph.* TO 'sgload'@'%' IDENTIFIED BY 'sg4ld!';

mysql>exit;
```

## [STAR](https://github.com/alexdobin/STAR)

> 

## [StringTie](http://ccb.jhu.edu/software/stringtie) [GitHub]()

> Samtools (included), Gclib (included)

## [subread](http://subread.sourceforge.net/)

> 

## [TransDecoder](https://github.com/TransDecoder/TransDecoder)

> 

## [Trim_galore](https://github.com/FelixKrueger/TrimGalore)

> python3-dev

> Perl Modules: Getopt::Long IPC::Open3 File::Spec File::Basename Cwd

## [Unicycler](https://github.com/rrwick/Unicycler)

> Linux or macOS, Python 3.4+, C++ compiler with C++14 support: [GCC](https://gcc.gnu.org/) 4.9.1+, [Clang](http://clang.llvm.org/) 3.5+, [ICC](https://software.intel.com/en-us/c-compilers), [setuptools](https://packaging.python.org/installing/#install-pip-setuptools-and-wheel) (only required for installation of Unicycler)

> For short-read or hybrid assembly: [SPAdes](http://bioinf.spbau.ru/spades) v3.6.2 - v3.13.0 (spades.py)

> For long-read or hybrid assembly: [Racon](https://github.com/isovic/racon) (racon)

> For polishing: [Pilon](https://github.com/broadinstitute/pilon) (pilon1.xx.jar), Java (java), [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/) (bowtie2-build and bowtie2), Samtools v1.0+ (samtools)

> For rotating circular contigs: BLAST+ (makeblastdb and tblastn)

> [Bandage](https://github.com/rrwick/Bandage)

## [Velvet](https://www.ebi.ac.uk/~zerbino/velvet/) [github](https://www.ebi.ac.uk/~zerbino/velvet/)

> make

## [wtdbg2](https://github.com/ruanjue/wtdbg2)

> 64-bit Linux only, Perl

---

# Python modules

## [GetOrganelle](https://github.com/Kinggerm/GetOrganelle)

> [SPAdes](https://github.com/ablab/spades), [Bowtie2](https://github.com/BenLangmead/bowtie2), [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi), [Bandage](https://github.com/rrwick/Bandage)

> Python 3.7.0(maintained), 3.5.1+ (compatible), 2.7.11+(compatible)

> Python modules: numpy>=1.16.4, scipy >=1.3.0, sympy >=1.4, requests

```
pip3 install --user sympy
```

## [JCVI](https://github.com/tanghaibao/jcvi), [my version](https://github.com/lufuhao/jcvi)

> EMBOSS, BEDTOOLS, Kent tools

> biopython boto3 coveralls cython deap ete3 gffutils jinja2 matplotlib networkx numpy graphviz PyPDF2 pytest pytest-cov pytest-benchmark PyYAML scipy seaborn

```
pip3 install --user biopython boto3 coveralls cython deap ete3 gffutils jinja2 matplotlib networkx numpy graphviz PyPDF2 pytest pytest-cov pytest-benchmark PyYAML scipy seaborn
```
## [MultiQC](https://multiqc.info/) [GitHub](https://github.com/ewels/MultiQC)

> Python v3.6+

> Python Mofules: numpy <1.17, matplotlib >=2.1.1,<3.0.0, jinja2 >=2.9,<3.0 markdown<=3.2, networkx <2.3, spectra>=0.0.10, click, coloredlogs, future>0.14.0, lzstring, pyyaml>=4, requests, simplejson, humanfriendly

```
pip3 install --user click coloredlogs future humanfriendly jinja2 lzstring markdown matplotlib networkx numpy pyyaml requests simplejson spectra
```

## [RSeQC](https://sourceforge.net/projects/rseqc/)

> python2.7/3, gcc, R

> cython>=0.17, pysam, bx-python, numpy, pyBigWig

```
pip3 install --user cython pysam bx-python numpy pyBigWig
```

---

# R packages

## [RIdeogram](https://cran.r-project.org/web/packages/RIdeogram/)

> librsvg2-dev

## [Circlize](https://cran.r-project.org/web/packages/circlize/)

> R: GlobalOptions, shape, grDevices, utils, stats, colorspace, methods, grid

---

# JAVA package

> To build a JAVA package, you probably need to install gradle

## [GATK](https://gatk.broadinstitute.org/hc/en-us) [GitHub](https://github.com/broadinstitute/gatk)

> JavaSE

> From source: gradle 5.6 (Autodownload), JDK8, Git 2.5+, git-lfs 1.1.0+, R 3.2.5

## [HANDS2](https://genomics.lums.edu.pk/software/hands2/)

> JavaSE

## [IGV Compiled](http://software.broadinstitute.org/software/igv/download)

> JavaSE >=11

## [IGV GitHub source](https://github.com/igvteam/igv)

> gradle, JavaSE >=11

```
sudo apt-get install gradle
```

## [InterProScan](https://www.ebi.ac.uk/interpro/download/), [EBI_FTP](ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/), [github](https://github.com/ebi-pf-team/interproscan)

> 64-bit Linux, Perl 5, Python 3

> Java JDK/JRE version 11 (Environment variables set: $JAVA_HOME should point to the location of the JVM, $JAVA_HOME/bin should be added to the $PATH

## [picard](https://github.com/broadinstitute/picard)

> JavaSE

## [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)

> JDK

## VGSC 

> Java >= 1.8.0

>     inst_JDK-v11.x.x.sh


---

# Libraries


## [GNUplot](http://www.gnuplot.info/)

> texdir, GD, libreadline-dev

```
sudo apt-get install texlive-latex-extra libgd3 libgd-dev libreadline-dev
```

## [HDF5](https://support.hdfgroup.org/ftp/HDF5/releases/), [GitHub](https://github.com/HDFGroup/hdf5)

> Require: szip (\$SZIP_ROOT)

> Export: HDF5_ROOT, HDF5_LIB, HDF5LIBDIR, HDF5_INC, HDF5INCLUDEDIR

## [HTSlib](https://github.com/samtools/htslib)

> autoconf, make, autoheader, gcc/g++/clang, perl

> zlib, libbz2, liblzma, libcurl, libcrypto

```
sudo apt-get install autoconf automake make gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev
```

## [szip](https://support.hdfgroup.org/doc_resource/SZIP/)

> Export: SZIP_ROOT




---

## Author:
    Fu-Hao Lu

    Professor, PhD

    State Key Labortory of Crop Stress Adaptation and Improvement

    College of Life Science

    Jinming Campus, Henan University

    Kaifeng 475004, P.R.China

    E-mail: LUFUHAO@HENU.EDU.CN
