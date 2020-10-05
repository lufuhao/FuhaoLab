#!/bin/bash
source FuhaoLab.conf


PackageName="seqan3"
PackageVers="v3.0.1"
InternetLink="https://github.com/seqan/seqan3/releases/download/3.0.1/seqan-3.0.1-with-submodules.tar.gz"
#http://packages.seqan.de/seqan3-library/seqan3-library-20181217.tar.xz
NameUncompress="seqan3"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers
#:<<EOM
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE

#cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "mkdir -p ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress/build"
#cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress/build
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX==${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "make"
#RunCmds "make test"
#if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
#	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
#fi
#RunCmds "make install"

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"


#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
