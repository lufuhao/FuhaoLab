#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVers="v1.10.2"
InternetLink="https://github.com/samtools/htslib/archive/1.10.2.tar.gz"
NameUncompress="htslib-1.10.2"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
unset LIBRARY_PATH; unset LD_LIBRARY_PATH;
RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export HTSDIR=$PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    HTSDIR    $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"

DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
