#!/bin/bash
#https://github.com/pachterlab/kallisto
source FuhaoLab.conf


PackageName="kallisto"
PackageVers="v0.46.1"
InternetLink="https://github.com/pachterlab/kallisto/archive/v0.46.1.tar.gz"
NameUncompress="kallisto-0.46.1"
TestCmd="./kallisto index"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress/build
RunCmds "mkdir -p $PROGPATH/$PackageName/$PackageVers/$NameUncompress/build"
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress/build
unset C_INCLUDE_PATH; unset CPLUS_INCLUDE_PATH
RunCmds "cmake -DCMAKE_INSTALL_PREFIX:PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
exit 0
