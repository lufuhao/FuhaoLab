#!/bin/bash
source FuhaoLab.conf
#http://hgdownload.cse.ucsc.edu/admin/

PackageName="kent"
PackageVersTmp="vlatest"
#InternetLink="http://hgdownload.cse.ucsc.edu/admin/jksrc.v403.zip"
#NameUncompress="kent"
#TestCmd="./bowtie --help"
MACHTYPE="x86_64"

PrintError "Warnings: It would take long time, and be patient..."

CheckPath $PackageName $PackageVersTmp
DeletePath ${PROGPATH}/$PackageName/$PackageVersTmp/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVersTmp/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVersTmp/$MACHTYPE
RunCmds "rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./"
#RunCmds "rsync -aP rsync://hgdownload-sd.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./"

cd ${PROGPATH}/$PackageName
PackageVers="v"$(stat -c '%y%m' twoBitToFa | sed 's/\s\+.*$//;s/-//g;')
mv ${PROGPATH}/$PackageName/$PackageVersTmp ${PROGPATH}/$PackageName/$PackageVers

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
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
