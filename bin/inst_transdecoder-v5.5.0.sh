#!/bin/bash
source FuhaoLab.conf
### https://github.com/TransDecoder/TransDecoder

PackageName="transdecoder"
PackageVers="v5.5.0"
InternetLink="${GITHUB_CUSTOM_SITE}/TransDecoder/TransDecoder/archive/TransDecoder-v5.5.0.tar.gz"
#InternetLink="https://sourceforge.net/projects/old-software-collection/files/TransDecoder-TransDecoder-v5.5.0.tar.gz"
NameUncompress="TransDecoder-TransDecoder-v5.5.0"
TestCmd="./TransDecoder.LongOrfs --version"
#TestCmd="./TransDecoder.Predict --version"

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make test"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
