#!/bin/bash
source FuhaoLab.conf


PackageName="halc"
PackageVersTemp="version"
InternetLink='https://github.com/lanl001/halc.git'
NameUncompress="halc"
TestCmd="./runHALC.py -h"
PackageVers="v1.1-a106f78"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
if [ -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/runHALC.py ]; then
	PrintInfo "Info: changing Shebang: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/runHALC.py"
	sed -i '1s/python$/python2/;' ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/runHALC.py
	sed -i 's/\r//;' ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/runHALC.py
else
	PrintError "Error: Shebang not changed: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/runHALC.py"
fi
#cd ${PROGPATH}/$PackageName/$NameUncompress
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make all"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"


cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
python2 $TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleInfo "HALC requires BLASR and LoRDEC"
ModuleAppend "###module load blasr LoRDEC"
ModuleAppend "prereq blasr"
ModuleAppend "prereq LoRDEC"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
