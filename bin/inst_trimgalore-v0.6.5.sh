#!/bin/bash
#https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/
#https://github.com/FelixKrueger/TrimGalore
#
#use Getopt::Long;
#use IPC::Open3;
#use File::Spec;
#use File::Basename;
#use Cwd;

source FuhaoLab.conf
if CmdExists fastqc; then
	echo "Info: FastQC detected"
else
	echo "Error: need to install FastQC first" >&2
	exit 100
fi
if CmdExists cutadapt; then
	echo "Info: cutadapt detected"
else
	echo "Error: need to install cutadapt first" >&2
	exit 100
fi

PackageName="trimgalore"
PackageVers="v0.6.5"
InternetLink="https://github.com/FelixKrueger/TrimGalore/archive/0.6.5.tar.gz"
NameUncompress="TrimGalore-0.6.5"
TestCmd="./trim_galore --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/x86_64
cd $PROGPATH/$PackageName/$PackageVers/x86_64
sed -i 's/\/usr\/bin\/perl/\/usr\/bin\/env perl/' trim_galore
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/x86_64
ModuleAppend "prereq    fastqc"
#ModuleAppend "prereq    cutadapt"
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/x86_64 "$PackageName-$PackageVers"
ModuleInfo "Requirement: module load fastqc cutadapt trimgalore"

exit 0
