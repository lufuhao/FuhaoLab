#!/bin/bash
source FuhaoLab.conf


PackageName="star"
PackageVers="v2.7.5c"
InternetLink="https://github.com/alexdobin/STAR/archive/2.7.5c.tar.gz"
NameUncompress="STAR-2.7.5c"
TestCmd="./STAR --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
cd ${PROGPATH}/$PackageName/$PackageVers
mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/source/
unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
RunCmds "make"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/Linux_x86_64
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/Linux_x86_64
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/Linux_x86_64 "$PackageName-$PackageVers"

exit 0
