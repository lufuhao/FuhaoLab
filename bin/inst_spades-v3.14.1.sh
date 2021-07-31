#!/bin/bash
source FuhaoLab.conf


PackageName="spades"
PackageVers="v3.14.1"
InternetLink="${GITHUB_CUSTOM_SITE}/ablab/spades/releases/download/v3.14.1/SPAdes-3.14.1.tar.gz"
NameUncompress="SPAdes-3.14.1"
TestCmd="./spades.py --help"

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
DeletePath=${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/build_spades
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/build_spades"
set -e
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/build_spades
#RunCmds "cmake -G \"Unix Makefiles\" -DCMAKE_INSTALL_PREFIX=\"${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE\" \"${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src\""
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE" "${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src"
RunCmds "make -j 8"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make install"

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
