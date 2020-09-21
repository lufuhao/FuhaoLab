#!/bin/bash
source FuhaoLab.conf
#http://hgdownload.cse.ucsc.edu/admin/

PackageName="kent"
PackageVers="vlatest"
#InternetLink="http://hgdownload.cse.ucsc.edu/admin/jksrc.v403.zip"
#NameUncompress="kent"
#TestCmd="./bowtie --help"
MACHTYPE="x64"

CheckPath $PackageName $PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./"
#RunCmds "rsync -aP rsync://hgdownload-sd.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./"

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
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/blat:\$PATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/blat"

exit 0
