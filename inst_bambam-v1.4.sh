#!/bin/bash
source FuhaoLab.conf


PackageName="bambam"
PackageVers="v1.4"
InternetLink="https://sourceforge.net/projects/bambam/files/bambam-1.4.tgz"
NameUncompress="bambam"
TestCmd="./bowtie --help"


NameCompress=$PackageName-$PackageVers.tgz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make all"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin

if [ ! -x polyCat ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"

exit 0
