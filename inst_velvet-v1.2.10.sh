#!/bin/bash
source FuhaoLab.conf


PackageName="velvet"
PackageVers="v1.2.10"
InternetLink="https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz"
NameUncompress="velvet_1.2.10"
TestCmd="./velvetg --help"

NameCompress=$PackageName-$PackageVers.tgz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make 'CATEGORIES=10' 'MAXKMERLENGTH=300' 'BIGASSEMBLY=1' 'LONGSEQUENCES=1' 'OPENMP=1' 'BUNDLEZLIB=1'"
RunCmds "make test"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
