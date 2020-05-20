#!/bin/bash
source FuhaoLab.conf


PackageName="last"
PackageVers="v1061"
InternetLink="http://last.cbrc.jp/last-1061.zip"
NameUncompress="last-1061"
TestCmd="./lastal --help"


NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "unzip $NameCompress"
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "make"
#RunCmds "make CXXFLAGS=-O3"
#RunCmds "make CXXFLAGS='-O3 -std=c++11 -pthread -DHAS_CXX_THREADS'"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install prefix=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
