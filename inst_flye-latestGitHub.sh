#!/bin/bash
source FuhaoLab.conf


PackageName="flye"
PackageVersTemp="version"
InternetLink='https://github.com/fenderglass/Flye.git'
NameUncompress="Flye"
TestCmd="./flye --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers="v"$(grep '__version__' ${PROGPATH}/$PackageName/$NameUncompress/flye/__version__.py | sed 's/.*__version__\s\+=\s\+\"//;s/\".*$//')"-"$(git branch -vv | cut -f 3 -d' ')
#PackageVers="v2.8.1-3ee5b33"
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
RunCmds "make"
#RunCmds "python3 flye/tests/test_toy.py"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
