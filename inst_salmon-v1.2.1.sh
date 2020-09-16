#!/bin/bash
source FuhaoLab.conf


PackageName="salmon"
PackageVers="v1.2.1"
InternetLink="https://github.com/COMBINE-lab/salmon/releases/download/v1.2.1/salmon-1.2.1_linux_x86_64.tar.gz"
NameUncompress="salmon-latest_linux_x86_64"
TestCmd="./salmon --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd $PROGPATH/$PackageName/$PackageVers
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
#AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleAppend "prepend-path    PATH    $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"

exit 0
