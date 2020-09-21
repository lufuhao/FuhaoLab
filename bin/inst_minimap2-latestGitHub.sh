#!/bin/bash
source FuhaoLab.conf


PackageName="minimap2"
PackageVersTemp="version"
InternetLink='https://github.com/lh3/minimap2.git'
NameUncompress="minimap2"
TestCmd="./minimap2 --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git describe --always --tags --dirty | perl -lne 's/-\d+-g/-/;print;')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
if [ -d ${PROGPATH}/$PackageName/$PackageVers ]; then
	DeletePath ${PROGPATH}/$PackageName/$PackageVers
fi
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
# make sse2only=1 to disable SSE4 code, which will make minimap2 slightly slower.
# make arm_neon=1 to compile for 32 bit ARM architectures (such as ARMv7)
# make arm_neon=1 aarch64=1 to compile for for 64 bit ARM architectures (such as ARMv8)
RunCmds "make aarch64=1"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddBashrc "## $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
