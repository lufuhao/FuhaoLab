#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVers="v1.10.2"
InternetLink="${GITHUB_CUSTOM_SITE}/samtools/htslib/archive/1.10.2.tar.gz"
NameUncompress="htslib-1.10.2"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers

#:<<EOM

DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
RunCmds "cmake -DCMAKE_INSTALL_PREFIX==${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
fi
RunCmds "make install"

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"


#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
