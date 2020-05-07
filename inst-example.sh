#!/bin/bash
source FuhaoLab.conf


PackageName="bowtie"
PackageVers="v1.2.3"
InternetLink="https://github.com/BenLangmead/bowtie/archive/v1.2.3.tar.gz"
NameUncompress="bowtie-1.2.3"
TestCmd="./bowtie --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --enable-lib --prefix=$PROGPATH/$PackageName/$PackageVers/x86_64 --with-gmapdb=$BIODATABASES/gmapdb"
RunCmds "make"
RunCmds "make check"
RunCmds "make install"
cd $PROGPATH/$PackageName/$PackageVers/x86_64/bin
bash $TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/x86_64
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/x86_64 "$PackageName-$PackageVers"
