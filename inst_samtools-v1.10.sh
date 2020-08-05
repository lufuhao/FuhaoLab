#!/bin/bash
source FuhaoLab.conf


PackageName="samtools"
PackageVers="v1.10"
InternetLink="https://github.com/samtools/samtools/archive/1.10.tar.gz"
NameUncompress="samtools-1.10"
TestCmd="./samtools --help"

if [ -z "$HTSDIR" ]; then
	PrintError "Error: please install HTSlib first and set HTSDIR to install root"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "autoheader"
RunCmds "autoconf -Wno-syntax"
#RunCmds "autoreconf"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-htslib=$HTSDIR"
RunCmds "make"
RunCmds "make check"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include
RunCmds "cp *.h ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include"
RunCmds "cp *.a ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
