#!/bin/bash
source FuhaoLab.conf


PackageName="stringtie"
PackageVers="v2.1.4"
InternetLink="http://ccb.jhu.edu/software/stringtie/dl/stringtie-2.1.4.tar.gz"
NameUncompress="stringtie-2.1.4"
TestCmd="./stringtie --help"

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "make release"
if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/stringtie ] || [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/stringtie ]; then
	PrintError "Error: executable not found: $PackageName"
	exit 100
fi
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "cp ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/stringtie ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
