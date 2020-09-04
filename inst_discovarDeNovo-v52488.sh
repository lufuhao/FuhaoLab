#!/bin/bash
source FuhaoLab.conf


PackageName="discovardenovo"
PackageVers="v52488"
InternetLink="ftp://ftp.broadinstitute.org/pub/crd/DiscovarDeNovo/latest_source_code/discovardenovo-52488.tar.gz"
NameUncompress="discovardenovo-52488"
TestCmd="./discovar --help"

libOpt=""
if [ -z "$JEMALLOC_ROOT" ]; then
	LibExist "libjemalloc"
else
	libOpt=" --with-jemalloc=$JEMALLOC_ROOT/lib"
fi

:<<EOM

NameCompress=$PackageName-$PackageVers.tar.gz
#CheckPath $PackageName $PackageVers
#DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
EOM
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $libOpt"
RunCmds "make all"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
exit 0
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
