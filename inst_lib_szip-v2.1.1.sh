#!/bin/bash
source FuhaoLab.conf
## https://support.hdfgroup.org/doc_resource/SZIP/
## https://github.com/erdc/szip


PackageName="szip"
PackageVers="v2.1.1"
InternetLink="https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz"
NameUncompress="szip-2.1.1"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make check"
if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
fi
RunCmds "make install"
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
