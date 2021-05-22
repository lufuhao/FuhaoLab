#!/bin/bash
source FuhaoLab.conf
#http://repeatmasker.org/RMBlast.html

PackageName="rmblast"
PackageVers="v2.11.0"
InternetLink="http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz"
NameUncompress="rmblast-2.11.0"
TestCmd="./rmblastn -h"
MACHTYPE="x64"

NameCompress=$PackageName-$PackageVers.x64.linux.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar -pxzvf $NameCompress"
fi
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
#ls -x -1 | grep -v 'rmblast' |xargs -i chmod -x {}

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
