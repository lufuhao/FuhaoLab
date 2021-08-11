# Fu-Hao Lab's scripts in Henan University, China

This repository is setup to further simplify the compilation and installation of BioSoft in Linux.

Just run the required scripts under bin/.



---

# Preparation

**Ubuntu 20.04**

Check out your machtype and set up your **MACHTYPE** variable

```
uname -m
```

Add following lines into your env file, such as "~/.bashrc"

```
export PROGPATH=${HOME}/Programs
export BIODATABASES=${HOME}/Databases
export MACHTYPE="x86_64"
export MODULEPATH=${PROGPATH}/bin/modules:$MODULEPATH
### $PROGPATH is the program installation root, all the programs will be installed in the folder
### $BIODATABASES id the database root, all the DB related files ill be installed in the folder
export FUHAOLAB_ROOT=/path/to/FuhaoLab
export PATH=${FUHAOLAB_ROOT}/bin:${FUHAOLAB_ROOT}/ubuntu_config:$PROGPATH/bin:$PATH
```

Then create the folders required

```
mkdir -p $PROGPATH $BIODATABASES ${PROGPATH}/bin/modules
```

---

# Raise an issue if you get any problem

> Raise a hand in this repository Issue if you have any problem, question or if you want some scripts for new softwares.

---

# Requirements

## Routine libraries

```

sudo apt-get install arj autoconf automake build-essential cmake convmv curl cython3 doxygen fig2dev g++ gcc git-all gnuplot libboost-dev libboost-all-dev libbz2-dev libcurl4-gnutls-dev libexpat1-dev libgd-dev libgd3 libglu1-mesa-dev libgsl0-dev libhdf5-dev libhpdf-dev libjemalloc-dev libjsoncpp-dev liblzma-dev libncurses5-dev libperl-dev libpng-dev qt5-default libreadline-dev libsparsehash-dev libsqlite3-dev libssl-dev libtbb-dev libterm-readline-gnu-perl libtool libxml-dom-xpath-perl libxml2-dev make mpack perl perl-doc p7zip-full p7zip-rar pigz python3-dev python3-pip python-setuptools python3-setuptools qtcreator rar sharutils sqlite3 subversion tcsh texlive-extra-utils texlive-fonts-extra texlive-latex-extra unace unrar unzip uudeview xfig xml2 yaggo zip zlib1g zlib1g-dev zsh zsh-common zstd

### Invalid libcurl4-openssl-dev python-pip

### openMPI
sudo apt-get install libopenmpi-dev libopenmpi3 openmpi-bin openmpi-common

### openSSH
sudo apt-get install openssh-client openssh-server 

### Interface
sudo apt-get install alacarte cabextract chromium-browser file-roller filezilla flashplugin-installer gedit-plugins gimp mesa-common-dev

#### Markdown editor [Typora](https://typora.io)
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
sudo apt-get install typora
```

## Python modules

```
sudo apt-get install python3.8-venv
```

```
pip3 install --user biopython cython matplotlib numpy pandas plotly psutil pysam scipy tabulate

pip3 install --user bokeh boto3 coveralls deap ete3 gffutils graphviz jinja2 joypy kaleido mappy networkx pyarrow PyPDF2 pytest pytest-benchmark pytest-cov scikit-learn spectra
```

## Perl modules

```
cpan -i Carp Clone Config::General Data::Dumper Digest::MD5 File::Basename File::Copy File::Spec::Functions File::Temp File::Which FindBin Font::TTF::Font GD GD::Polyline Getopt::Long List::MoreUtils List::Util Log::Log4perl Math::Bezier Math::BigFloat Math::Round Math::VecStat Memoize Params::Validate Pod::Usage Readonly Regexp::Common SVG Set::IntSpan Statistics::Basic Storable Text::Balanced Text::Format Time::HiRes



perl -MCPAN -e 'force install BioPerl'

#need samtools compiled using fPic
perl -MCPAN -e 'install Bio::DB::Sam'

```

## R modules

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.12")

### Bioconductor
clusterProfiler, AnnotationForge, RSQLite, DBI, DESeq2, GO.db

### R-project
optparse, dplyr, stringr, jsonlite, purrr, RCurl

```

---

# Softwares

## [ABySS](https://www.bcgsc.ca/resources/software/abyss) [GitHub](https://github.com/bcgsc/abyss)

> boost, openmpi, sparsehash

```
sudo apt-get install libboost-dev libboost-all-dev openmpi-bin libsparsehash-dev
```

> [ARCS](https://github.com/bcgsc/arcs), [Tigmint](https://github.com/bcgsc/tigmint), [samtools](https://samtools.github.io/)

> [pigz](https://zlib.net/pigz/), [zsh](https://sourceforge.net/projects/zsh/)

```
sudo apt-get install pigz zsh zsh-common
```

## [ALLPATHS-LG](http://software.broadinstitute.org/allpaths-lg/blog/?page_id=12)

> doi: [10.1101/gr.141515.112](https://dx.doi.org/10.1101/gr.141515.112)
>
> [GCC](http://gcc.gnu.org/) v4.7.0+, [GMP](http://gmplib.org/) library compiled with the C++ interface, [Picard](http://picard.sourceforge.net/) set, command dot from the [graphviz](http://www.graphviz.org/) package.

```
sudo apt-get install libgmp-dev graphviz
```
## [Aspera-Connect](https://www.ibm.com/aspera/connect/)

> OpenSSL (>=v1.0.2g), Mesa EGL, glib2 (>=v2.28)

## [ATACseqMappingPipeline](https://github.com/lufuhao/ATACseqMappingPipeline)

> bamaddrg bedtools bowtie cutadapt fastqc FuhaoPerl5Lib FuhaoBin htslib picard samtools/v0.1.20 trimgalore trimmomatic

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

## [bcftools](https://github.com/samtools/bcftools)

> make, gcc, autoheader, autoconf, bash, perl

> [GNU Scientific library](https://www.gnu.org/software/gsl/), HTSlib, zlib

```
sudo apt-get install libgsl0-dev libperl-dev
```

## bedops [GitHub](https://github.com/bedops/bedops) [Docs](https://bedops.readthedocs.io/)

> doi: [10.1093/bioinformatics/bts277](http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract)

> Requirements: GCC 4.8.2+ (gcc, g++, C++11)

## [BEDtools](https://github.com/arq5x/bedtools2)

>

## [BLASR](https://github.com/mchaisso/blasr)

> Require: HDF5 (HDF5INCLUDEDIR, HDF5LIBDIR)

## [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi) [FTP](ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/)

>

## [Bowtie](http://bowtie-bio.sourceforge.net/) [GitHub](https://github.com/BenLangmead/bowtie)

> libtbb-dev

## [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml), [GitHub]()

> libtbb-dev, zlib, Java　(for SRA support)

## [BWA](http://bio-bwa.sourceforge.net/) [GitHub](https://github.com/lh3/bwa)

> zlib

## [canu](https://github.com/marbl/canu)

> 16GB Mem; GCC 4.5; GCC 7+

> Perl 5.12.0+: File::Path 2.08

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

## [CNVnator](https://github.com/abyzovlab/CNVnator)

> make, gcc, readline

> [CERN ROOT](https://root.cern/) [github](https://github.com/root-project/root.git), samtools with HTSlib, [YEPPP](http://www.yeppp.info/)

```
sudo apt-get install libreadline-dev
```
CMAKE_CXX_STANDARD=14 


## [csvtk](https://github.com/shenwei356/csvtk)

> Go

## [Diamond](http://www.diamondsearch.org/index.php) [GitHub](https://github.com/bbuchfink/diamond)

> cmake

## Discovar [NotWorking]

### [DISCOVARdenovo](https://software.broadinstitute.org/software/discovar/blog/)

> 64 bit x86_64 based linux, GCC >= 4.7.0, jemalloc, samtools

```
apt-get install libjemalloc-dev
```

### [DISCOVARvariantcaller](https://software.broadinstitute.org/software/discovar/blog/)

> GCC >= 4.7.0

## [DSK](https://github.com/GATB/dsk)

> Requirements: CMake 3.1+, gcc 4.7+

> doxygen

## [Eagle](https://github.com/tony-kuo/eagle)

> [HTSLIB](https://github.com/samtools/htslib)

## [Edena](http://www.genomic.ch/edena)

> g++

## [EMBOSS](http://emboss.sourceforge.net/download)

> JDK (JAVA_HOME), libhpdf-dev, libpng-dev

```
sudo apt-get install libhpdf-dev libpng-dev
```

## [Estimate_Genome_Sizze](https://github.com/josephryan/estimate_genome_size.pl)

> Requirements: Perl

## [Exonerate](https://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate) [GitHub](https://github.com/nathanweeks/exonerate)

> autoreconf, glib

```
apt -get install libglib2.0-dev
```

## [Falcon](https://github.com/PacificBiosciences/FALCON-integrate)

> Python2-dev, nim

## [Fastp](https://github.com/OpenGene/fastp)

> zlib

## [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/download.html)

> Perl modules: FindBin, Getopt::Long

## [Fastq-Tools](https://homes.cs.washington.edu/~dcjones/fastq-tools/) [GitHub](https://github.com/dcjones/fastq-tools)

> 

## [Flye](https://github.com/fenderglass/Flye/)

> Python 2.7 or 3.5+ with setuptools C++ compiler with C++11 support (GCC 4.8+)

> GNU make, Git, Core OS development headers (zlib, ...)

## [FuhaoPerl5Lib](https://github.com/lufuhao/FuhaoPerl5Lib)

> Perl: BioPerl,Bio::DB::Sam,Cwd,Data::Dumper,File::Copy,File::Which,Scalar::Util,Statistics::Basic,Storable

> samtools,seqtk,CDBtools

## [Gblocks](http://molevol.cmima.csic.es/castresana/Gblocks.html)

> 

## [Gemma](https://github.com/genetics-statistics/GEMMA/) [DOI](https://dx.doi.org/10.1086/519795)

> C++ tool chain >= 5.5.0, GNU Science library (GSL) 2.x, blas/openblas, lapack, zlib

```
sudo apt-get install libopenblas-dev libgsl-dev liblapack-dev zlib1g-dev
```

## [GeneTribe](https://github.com/chenym1/genetribe)

> doi:[10.1016/j.molp.2020.09.019](https://doi.org/10.1016/j.molp.2020.09.019) [Site](http://wheat.cau.edu.cn/TGT/)
>
> blastplus, bedtools, jcvi

## [genometools](http://genometools.org/pub/)

> Include: LTRharvest

> Requirements: GNU make v3.8+, libcairo2-dev [cairo.h], libpango1.0-dev [pangocairo.h]

```
sudo apt-get install libcairo2-dev libpango1.0-dev
```

## [GenmeThreader](https://genomethreader.org)

> 

## [Gerbil](https://github.com/uni-halle/gerbil)

```
sudo apt-get install git cmake g++ libboost-all-dev libz3-dev libbz2-dev
```

## [gffcompare](https://github.com/gpertea/gffcompare)

> Requiremments: g++

## [gffread](https://github.com/gpertea/gffread)

> [gclib](https://github.com/gpertea/gclib), make

## [GMAP/GSNAP](http://research-pub.gene.com/gmap/)

> zlib, bzip2

## [HALC](https://github.com/lanl001/halc)

>  A high throughput algorithm for long read error correction. HALC aligns  the long reads to short read contigs from the same species with a  relatively low identity requirement so that a long read region can be  aligned to at least one contig region, including its true genome  region’s repeats in the contigs sufficiently similar to it (similar  repeat based alignment approach). It then constructs a contig graph and, for each long read, references the other long reads’ alignments to find the most accurate alignment and correct it with the aligned contig  regions (long read support based validation approach). 

> BLASR, LoRDEC (only for -ordinary mode), g++, Python2

## [HISAT2](https://daehwankimlab.github.io/hisat2), [Github](https://github.com/DaehwanKimLab/hisat2)

> 

## [HMMER](http://hmmer.org) [GitHub](https://github.com/EddyRivasLab/hmmer)

> [easel](https://github.com/EddyRivasLab/easel)

## [IOGA](https://github.com/holmrenser/IOGA) [NotWorking due to python2]

> Python2, BioPython, BBmap, SOAPdenovo2, SeqTK, SPAdes.py, ALE, Samtools 0.1.19, Picardtools

## [IQ-tree](http://www.iqtree.org/) [GitHub] [v1](https://github.com/Cibiv/IQ-TREE) [v2](https://github.com/iqtree/iqtree2)

> GCC>=v4.8; cmake; Boost lib; Eigen3 lib; openMP lib

> sudo apt-get install libeigen3-dev libopenmpi-dev libboost-dev

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

## [KMC](https://sun.aei.polsl.pl/kmc/) [GitHub](https://github.com/refresh-bio/KMC)

> gcc 4.9+

## [LAST](https://gitlab.com/mcfrith/last)

> g++; >2G memory

> if errors are reported in 'make', try to comment line20 and uncomment line21 or line22

## [LoRDEC](http://www.atgc-montpellier.fr/lordec/)

> doi: [10.1093/bioinformatics/btu538](https://dx.doi.org/10.1093/bioinformatics/btu538)
>
> gcc/g++ 4.8+, [GATB](https://github.com/GATB/gatb-core) (auto-download), libboost (auto-download), make, cmake, zlib1g-dev, wget

## [LTR_retriever](https://github.com/oushujun/LTR_retriever)

> BLAST+ (makeblastdb, blastn, blastx), CDHIT (cd-hit-est), HMMER (hmmsearch), RepeatMasker

## [MAFFT](https://mafft.cbrc.jp/alignment/software/)

> 

## Mason

### [Mason](http://packages.seqan.de/mason/)

> 

### [Mason2](http://packages.seqan.de/mason2)

>

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

## [MiniConda3](https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/)

> bzip2

> After installation, export PATH and execuate following
```
#https://mirrors.bfsu.edu.cn/help/anaconda/ 
#https://mirrors.nju.edu.cn/anaconda/
#https://mirrors.sjtug.sjtu.edu.cn/anaconda/

conda config --add channels https://mirrors.bfsu.edu.cn/anaconda/cloud/bioconda/
conda config --add channels https://mirrors.bfsu.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.bfsu.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.bfsu.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.bfsu.edu.cn/anaconda/pkgs/r/
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
### display installed channel
conda config --set show_channel_urls yes
### display added channel
conda config --get channels

### set conda envs and package cache
if [ ! -z $PROGPATH ]; then (mkdir /home/hpcsoft/TestSoft/libraries/miniconda3/envs;mkdir /home/hpcsoft/TestSoft/libraries/miniconda3/pkgs;conda config --add envs_dirs /home/hpcsoft/TestSoft/libraries/miniconda3/envs;conda config --add pkgs_dirs /home/hpcsoft/TestSoft/libraries/miniconda3/pkgs;) else (echo "Error: You may need to set PROGPATH first" >&2;) fi

###
cat $HOME/.condarc
```

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

## [Ninja v0.95](https://github.com/TravisWheelerLab/NINJA/releases/tag/0.95-cluster_only)

```
sudo apt-get install doxygen
```

## [NLGenomeSweeper](https://github.com/ntoda03/NLGenomeSweeper)

>  Python >=3.5; blast+; MUSCLE aligner; SAMtools; bedtools; HMMER; InterProScan with PANTHER database; TransDecoder

## [NLR-Annotator](https://github.com/steuernb/NLR-Annotator)

> MEME, JRE > 1.6

>    MEME 5.1: ./inst_NLRannotator-latestGitHub-nlr_parser3.sh

>    MEME < 4.9.1: ./inst_NLRannotator-v0.7beta9281f70.sh

## [NOVOPlasty](https://github.com/ndierckx/NOVOPlasty)

> Perl

## [Phylip](https://evolution.genetics.washington.edu/phylip.html)

> 

## [Phy-Mer](https://github.com/MEEIBioinformaticsCenter/phy-mer)

> Python2/3, Pysam (0.7.4 tested), BioPython (1.58 tested)

```
pip3 install --user pysam biopython
```

## [Plink](http://zzz.bwh.harvard.edu/plink/index.shtml) [GitHub](https://github.com/chrchang/plink-ng) [DOI](https://dx.doi.org/10.1086/519795)

```
sudo apt-get install zstd libatlas-base-dev liblapack-dev
```

## polyCat (see bambam above)

> BioPerl, [BAMtools](https://github.com/pezmaster31/bamtools)

## polyDog (see bambam above)

> 

## [Primer3](https://github.com/primer3-org/primer3)

> build-essential g++ cmake git-all

## [proovread](https://github.com/BioInf-Wuerzburg/proovread)

>  doi: [10.1093/bioinformatics/btu392](https://dx.doi.org/10.1093/bioinformatics/btu392)

> Perl 5.10.1+: Cwd Data::Dumper File::Basename File::Copy(v5.34core) File::Path File::Spec File::Temp File::Which FindBin Getopt::Long List::Util Log::Log4perl Storable Thread::Queue threads Time::HiRes

> Blast-2.2.24+, samtools-1.1+

## [R](https://cloud.r-project.org/)

> 

## [Racon](https://github.com/isovic/racon)

> gcc 4.8+ or clang 3.4+, cmake 3.2+

## [Ray](https://github.com/sebhtml/ray)

> [RayPlatform](https://github.com/sebhtml/RayPlatform)

## [RECON](http://eddylab.org/software/recon/)

> [v1.08 for RepeatModeler](http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz)

## [RepeatMasker](http://repeatmasker.org/RepeatMasker/)

> Perl v5.8.0+: FindBin, Carp, Getopt::Long, Storable, Pod::Text, File::Copy, File::Spec, File::Path, Data::Dumper, Cwd

> python3 [h5py](https://docs.h5py.org/en/latest/build.html), [RMBlast](http://www.repeatmasker.org/RMBlast.html), [TRF](http://tandem.bu.edu/trf/trf.html), Repeat Database: [Dfam](http://www.dfam.org)

> Go to [Dfam](https://www.dfam.org/) https://www.dfam.org/releases/Dfam_3.3/families/Dfam.h5.gz ~15Gb and download to $PROGPATH/repeatmasker/

> Download RepBaseRepeatMaskerEdition-20181026.tar.gz to $PROGPATH/repeatmasker/

```
sudo apt-get install libtext-soundex-perl
pip3 install --user h5py
cd $PROGPATH/repeatmasker/vX.X.X/x86_64
./configure
```

## [RepeatModeler](http://www.repeatmasker.org/RepeatModeler/)

> Requires: [Perl](http://www.perl.org/get.html), [RepeatMasker & Libraries](http://www.repeatmasker.org/RepeatMasker), [RECON v1.0.8](http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz), [RepeatScout v1.0.6](http://www.repeatmasker.org/RepeatScout-1.0.6.tar.gz), [TRF](http://tandem.bu.edu/trf/trf.html), [RMBlast](http://www.repeatmasker.org/RMBlast.html), UCSC [kent](http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/) TwoBit Tools (twoBitToFa, faToTwoBit, twoBitInfo etc)

> Optional: [ABBlast](http://blast.advbiocomp.com/licensing/)

> Optional: [genometools](http://genometools.org/pub/), [Ltr_retriever](https://github.com/oushujun/LTR_retriever/releases), [MAFFT](https://mafft.cbrc.jp/alignment/software/), [CD-HIT](http://weizhongli-lab.org/cd-hit/), [Ninja v0.95](https://github.com/TravisWheelerLab/NINJA/releases/tag/0.95-cluster_only)

```
perl ./configure
```

## [RepeatScout](https://bix.ucsd.edu/repeatscout/)

> [v1.0.6 for RepeatScout](http://www.repeatmasker.org/RepeatScout-1.0.6.tar.gz)

> Requirements: perl 5.5+, RepeatMasker-open3.0+, [nseg](ftp://ftp.ncbi.nih.gov/pub/seg/nseg), [trf](http://tandem.bu.edu/trf/trf.html)

## [REPET](https://urgi.versailles.inra.fr/Tools/REPET) NOT working

> Python2: MySQLdb, logging, yaml; MySQL v5.0+ with engine MyISAM; SLURM; BLAST+ v2.2.26+

> Optional: [RECON](http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz), [PILER](http://www.drive5.com/piler/), [hmmer3](http://hmmer.org/), blastclust v2.2.20+/[MCL](https://micans.org/mcl/src) v1.008, [RepeatMasker](http://www.repeatmasker.org/RMDownload.html), [TRF](http://tandem.bu.edu/trf/trf.download.html) v4.04, [MAFFT](https://mafft.cbrc.jp/alignment/software/), [RepeatScout](https://bix.ucsd.edu/repeatscout/) v1.0.5, [LTRHarvest](http://genometools.org/pub/)

## [RMBlast](http://www.repeatmasker.org/RMBlast.html)

> 

## [RSEM](https://github.com/deweylab/RSEM)

> C++, Perl and R, Python, perl-doc

> Bowtie/Bowtie2/STAR/HISAT2

## [Sambamba](https://github.com/biod/sambamba)

> D compiler (ldc), BioD (git submodule), GCC tool chain (for htslib and lz4), htslib (git submodule), undeaD (git submodule), libz, liblz4

>    inst_lib_ldc-v1.22.0.sh

## [Salmon](https://combine-lab.github.io/salmon/)

> libbz2, liblzma, Boost, Cereal, libtbb, libcurl, PkgConfig, libgff, Jemalloc, libstadenio, pufferfish, zlib1g, 

> #Will automatically download libgff, Jemalloc, Cereal,libstadenio, pufferfish

```
sudo apt install libboost-dev libboost-all-dev libbz2-dev libcurl4-gnutls-dev liblzma-dev libtbb-dev zlib1g-dev 
```

## [samtools](https://github.com/samtools/samtools)

> zlib, GNU ncurses, [HTSlib](https://github.com/samtools/htslib)

> #inst_samtools-v0.1.20.fPIC.sh is only for Bio::DB::Sam installation

## [seqkit](https://github.com/shenwei356/seqkit)

> doi: [10.1371/journal.pone.0163962](https://dx.doi.org/10.1371/journal.pone.0163962)
>
> Go language

```
sudo apt-get install golang gox
```

## [seqtk](https://github.com/lh3/seqtk)

> make

## [SGA](https://github.com/jts/sga.git)

> Requirements: google [sparsehash](https://github.com/sparsehash/sparsehash) library (set SPARSEHASH_ROOT), [zlib](http://www.zlib.net/) (set JEMALLOC_ROOT),  the [jemalloc](http://www.canonware.com/jemalloc/download.html) memory allocator (set BAMTOOLS_ROOT)

> BWA

> Requirements: Python modules: pysam, [ruffus](http://www.ruffus.org.uk/)

```
apt-get install libsparsehash-dev libjemalloc-dev zlib1g-dev

pip3 install --user pysam ruffus
```

## [Sickle](https://github.com/najoshi/sickle)

> Requirements: GCC, kseq.h (included), zlib

## [Smartdenovo](https://github.com/ruanjue/smartdenovo)

> Perl

## [Sniffles](https://github.com/fritzsedlazeck/Sniffles)

> cmake, make

## [SNPyho](https://github.com/thlee/SNPhylo)

> Rscript; Python; MUSCLE; dnaml

## [SNPsplit](http://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/) [GitHub](https://github.com/FelixKrueger/SNPsplit)

> Perl, Samtools

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

## [SRA-toolkit](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software) [GitHub](https://github.com/ncbi/sra-tools)

> 

## [STAR](https://github.com/alexdobin/STAR)

> 

## [StringTie](http://ccb.jhu.edu/software/stringtie) [GitHub]()

> Samtools (included), Gclib (included)

## [subread](http://subread.sourceforge.net/)

> 

## [TaxonKit](https://bioinf.shenwei.me/taxonkit) [GitHub](https://github.com/shenwei356/taxonkit) [doi](https://doi.org/10.1101/513523 )

> Go

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

## [VCF2Dis](https://github.com/BGI-shenzhen/VCF2Dis)

> Requirements: zlib

## [VCFtools](https://github.com/vcftools/vcftools) [GitHubPages](https://vcftools.github.io)

>

## [wtdbg2](https://github.com/ruanjue/wtdbg2)

> 64-bit Linux only, Perl

---

---

---

# Python modules

## [Badread](https://github.com/rrwick/Badread)

> 

## [bioconvert](https://github.com/bioconvert/bioconvert)

> easydev colorlog pandas biopython>=1.70 mappy matplotlib networkx pyyaml pysam pyexcel pyexcel-ods3 pyexcel-xls xlrd pyBigWig py2bit

> pyexcel-xls 0.6.2 has requirement xlrd<2

```
pip3 install --user easydev colorlog pandas biopython>=1.70 mappy matplotlib networkx pyyaml pysam pyexcel pyexcel-ods3 xlrd pyBigWig py2bit
```

## [CNVpytor](https://github.com/abyzovlab/CNVpytor) NOT working

> requests>=2.0, gnureadline, pathlib>=1.0, pysam>=0.15, numpy>=1.16, scipy>=1.1, matplotlib>=2.2, h5py>=2.9, xlsxwriter>=1.3

> Note: difficult to install gnureadline

```
pip3 install --user requests gnureadline pathlib pysam numpy scipy matplotlib h5py xlsxwriter
```

## [CutAdapt](https://github.com/marcelm/cutadapt)

> Python modules: dnaio xopen isal

```
pip3 install --user dnaio xopen isal
```

## [deepTools](https://github.com/deeptools/deepTools)

> pip3 install --user matplotlib numpy numpydoc plotly py2bit pyBigWig pysam scipy cycler pillow certifi kiwisolver python-dateutil pyparsing sphinx Jinja2 six alabaster sphinxcontrib-htmlhelp sphinxcontrib-applehelp sphinxcontrib-jsmath snowballstemmer Pygments sphinxcontrib-serializinghtml sphinxcontrib-qthelp docutils babel requests packaging sphinxcontrib-devhelp imagesize setuptools MarkupSafe pytz

## [eggNOG-mapper](http://eggnog-mapper.embl.de) [GitHub](https://github.com/eggnogdb/eggnog-mapper)

> py2: biopython, python2

> py3: biopython, python3.7+

## [GetOrganelle](https://github.com/Kinggerm/GetOrganelle)

> [SPAdes](https://github.com/ablab/spades), [Bowtie2](https://github.com/BenLangmead/bowtie2), [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi), [Bandage](https://github.com/rrwick/Bandage)

> Python 3.7.0(maintained), 3.5.1+ (compatible), 2.7.11+(compatible)

> Python modules: numpy>=1.16.4, scipy >=1.3.0, sympy >=1.4, requests

```
pip3 install --user sympy
```

## [HTseq](https://htseq.readthedocs.io/en/master/), [GitHub](https://github.com/htseq/htseq)

```
pip3 install --user matplotlib Cython pysam numpy
```

## [HyLiTE](http://hylite.sourceforge.net)

> Requirements: python 3 (3.6.1+), scipy (1.0.0+), bowtie2 (2.1.0+), samtools (0.1.19+ or 1.2+)

>     * bowtie2 and samtools are not necessary once a .pileup file has been obtained. *

```
pip3 install --user scipy
```

## [JCVI](https://github.com/tanghaibao/jcvi), [my version](https://github.com/lufuhao/jcvi)

> EMBOSS, BEDTOOLS, Kent tools

> biopython boto3 coveralls cython deap ete3 gffutils jinja2 matplotlib networkx numpy graphviz PyPDF2 pytest pytest-cov pytest-benchmark PyYAML scipy seaborn 

> brewer2mpl ftpretty goatools more-itertools natsort ortools rich scikit_image webcolors

```
pip3 install --user biopython boto3 coveralls cython deap ete3 gffutils jinja2 matplotlib networkx numpy graphviz PyPDF2 pytest pytest-cov pytest-benchmark PyYAML scipy seaborn

pip3 install --user brewer2mpl ftpretty goatools more-itertools natsort ortools rich scikit_image webcolors
```

## [kingfisher](https://github.com/wwood/kingfisher-download)

> bird_tool_utils>=0.2.17; extern

```
pip3 install --user bird_tool_utils extern
```

## [MACS](https://github.com/macs3-project/MACS)

> GCC 5.2.0; [NumPy](http://www.scipy.org/Download); cython (Optional); [cykhash](https://github.com/realead/cykhash);[fermi-lite](https://github.com/lh3/fermi-lite)/[simde](https://github.com/simd-everywhere/simde)

```
pip3 install --user numpy cython cykhash pytest pytest-cov codecov setuptools
```

## [MultiQC](https://multiqc.info/) [GitHub](https://github.com/ewels/MultiQC)

> Python v3.6+

> Python Mofules: numpy <1.17, matplotlib >=2.1.1,<3.0.0, jinja2 >=2.9,<3.0 markdown<=3.2, networkx <2.3, spectra>=0.0.10, click, coloredlogs, future>0.14.0, lzstring, pyyaml>=4, requests, simplejson, humanfriendly

```
pip3 install --user click coloredlogs future humanfriendly jinja2 lzstring markdown matplotlib networkx numpy pyyaml requests simplejson spectra MarkupSafe python-dateutil certifi cycler pillow kiwisolver pyparsing decorator colormath
```

## [NanoFilt](https://github.com/wdecoster/nanofilt)

```
pip3 install --user pandas biopython pytz python-dateutil numpy
```

## [NanoPack](https://github.com/wdecoster/nanopack)

> Submodules: NanoStat nanomath NanoPlot nanoget NanoLyse nanoQC NanoFilt NanoComp

```
pip3 install --user joypy matplotlib numpy pandas plotly pyarrow seaborn biopython mappy kaleido pauvre pysam python-dateutil scipy bokeh Python-Deprecated pillow cycler pyparsing certifi kiwisolver pytz six retrying scikit_learn Jinja2 PyYAML packaging tornado typing_extensions threadpoolctl joblib psutil MarkupSafe
```

## [QUAST](http://bioinf.spbau.ru/quast) [GitHub](https://github.com/ablab/quast)

> python3.3+/2.5+, perl 5.6.0+, GCC 4.7+, make, ar, zlib

> perl module: Time::HiRes, Java 1.8+, R: Matplotlib 1.1+

> install_full needs: BLAST+, Augusus, BUSCO databases (bacteria, eukaryota, fungi)

```
cpan Time::HiRes
pip3 install matplotlib
sudo apt-get install -y pkg-config libfreetype6-dev libpng-dev zlib1g-dev
```

## [RSeQC](https://sourceforge.net/projects/rseqc/)

> python2.7/3, gcc, R

> cython>=0.17, pysam, bx-python, numpy, pyBigWig

```
pip3 install --user cython pysam bx-python numpy pyBigWig
```

## [TOBIAS](https://github.com/loosolab/TOBIAS)

> Requirements: numpy, scipy, pysam, pybedtools, matplotlib>=2, scikit-learn, pandas, pypdf2, xlsxwriter, adjustText, pyBigWig>=0.3, MOODS-python, svist4get>=1.2.24, gimmemotifs, logomaker, seaborn>=0.9.1, boto3, pyyaml>5.1, kneed

```
pip3 install --user numpy scipy pysam pybedtools matplotlib scikit-learn pandas pypdf2 xlsxwriter adjustText pyBigWig MOODS-python svist4get gimmemotifs logomaker seaborn boto3 pyyaml kneed
```

## [WGDI](https://github.com/SunPengChuan/wgdi)

> Python3: pandas>=1.1.0, numpy, biopython, matplotlib, scipy



---

---

---

# R packages

## [RIdeogram](https://cran.r-project.org/web/packages/RIdeogram/)

> librsvg2-dev

## [Circlize](https://cran.r-project.org/web/packages/circlize/)

> R: GlobalOptions, shape, grDevices, utils, stats, colorspace, methods, grid

---

---

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

## [pilon](https://github.com/broadinstitute/pilon)

> JavaSE

## [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) [GitHub](https://github.com/usadellab/Trimmomatic)

> JDK

## VGSC 

> Java >= 1.8.0

>     inst_JDK-v11.x.x.sh

---

---

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

> [zlib](http://zlib.net), [libbz2](http://bzip.org/), [liblzma](http://tukaani.org/xz/), [libcurl](https://curl.haxx.se/), [libcrypto](https://www.openssl.org/)

```
sudo apt-get install autoconf automake make gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev
```

## [ROOT](https://root.cern/) [GitHub](https://github.com/root-project/root)

> [Install_notes]: https://root.cern/install/

```
sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
 libxft-dev libxext-dev python openssl

sudo apt-get install gfortran libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev libfftw3-dev libcfitsio-dev graphviz-dev libavahi-compat-libdnssd-dev libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev
```

## [seqan3](http://www.seqan.de/) [GitHub](https://github.com/seqan/seqan3)

> Requirements: GCC v7+, cmake v3.4+, [SDSL](https://github.com/xxsds/sdsl-lite) v3+ (Included), [Range-V3](https://github.com/ericniebler/range-v3) v0.11.0+ (Included), [cereal](https://github.com/USCiLab/cereal) v1.2.3+ (Included), [zlib](https://github.com/madler/zlib), v1.2+, [bzip2](http://www.bzip.org/) v1.0+

## [szip](https://support.hdfgroup.org/doc_resource/SZIP/)

> Export: SZIP_ROOT

---

---

---

# MiniConda3

## [pb-assembly](https://github.com/PacificBiosciences/pb-assembly)

---

---

---

# System

## [Bpytop](https://github.com/aristocratos/bpytop) Resource monitor

> Python3.6+, psutil v5.7.0+



## [croc](https://github.com/schollz/croc): 安全性极强的点对点传输工具、FTP替代



> curl https://getcroc.schollz.com | bash

or

> snap install croc

MAC:

> brew install croc









# To-do List

[ ] [dev_sidebar](https://github.com/docmirror/dev-sidecar): GitHub加速，DNS优选 【Win】【Mac】

[ ] [Circoletto](https://github.com/infspiredBAT/Circoletto) [online server](http://tools.bat.infspire.org/circoletto/): Circos可视化blast结果

> circos &amp; circos-tools http://circos.ca/software/download/tools
>
> BLAST
>
> BioPerl

[ ] [LIII](https://github.com/aliakseis/LIII): BT download

[ ] [CPAT](http://rna-cpat.sourceforge.net) [Publication](http://nar.oxfordjournals.org/content/41/6/e74.long)

[ ] [CPC2](https://github.com/biocoder/CPC2) [online](http://cpc2.gao-lab.org/)

> 为CPC 的升级版，发布于2017 年，是目前最新的lncRNA 鉴定工具，也代表着lncRNA  鉴定的最新研究进展。在经过大量的特征选择后，CPC2 最终的特征主要包括四条：最长ORF 长度，ORF 的完整性，Fickett 分数以及等电点 (isoelectric point, pI)[39,40]。其中等电点特征主要是通过将最长ORF  翻译为氨基酸序列，而后根据氨基酸等电点这一理化性质计算而得。与大多lncRNA 鉴定工具相同，CPC2 也使用了支持向量机来构建分类器。

[ ] [PLEK](https://sourceforge.net/projects/plek)

> PLEK软件通过序列的kmer构成来区分编码和非编码转录本，不需要通过比对来完成，所以运行速度较快，同时其性能受到测序错误的影响的概率较低，比较稳定。

[ ] [lncFinder](http://bmbl.sdstate.edu/lncfinder/)

> LncFinder是一种新的lncRNA识别工具。基于六聚体的对数距离，多尺度结构信息和从快速离散傅立叶变换获得的理化特征。为了确定最佳分类器，使用10倍交叉验证对五种广泛使用的机器学习算法进行了验证：逻辑回归，支持向量机（SVM），随机森林，极限学习机器和深度学习。最终选择SVM作为LncFinder的分类器。经过全面的功能选择和模型验证方案的评估，LncFinder在多个物种上的表现优于几种最先进的工具。用户可以轻松，高效地使用新的数据集或不同的机器学习算法对LncFinder进行重新训练。

[ ] [BETA](http://cistrome.org/BETA/) doi: 10.1038/nprot.2013.150

> Target analysis by integration of transcriptome and ChIP-seq data with BETA

[ ] [SeqAcademy](http://www.seqacademy.org/) [GitHub](https://github.com/NCBI-Hackathons/seqacademy)


[ ] [ECtools](https://github.com/jgurtowski/ectools)

[ ] [CLARI-TE](https://github.com/jdaron/CLARI-TE)





# Author:

    卢福浩(Fu-Hao Lu)
    
    Professor, PhD
    
    作物逆境适应与改良国家重点实验室，生命科学学院
    
    State Key Labortory of Crop Stress Adaptation and Improvement
    
    College of Life Science
    
    河南大学金明校区
    
    Jinming Campus, Henan University
    
    开封 475004， 中国
    
    Kaifeng 475004, P.R.China
    
    E-mail: LUFUHAO@HENU.EDU.CN
