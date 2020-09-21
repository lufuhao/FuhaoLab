#!/bin/bash
source FuhaoLab.conf


PackageName="hisat2"
PackageVersTemp="version"
InternetLink='https://github.com/DaehwanKimLab/hisat2.git'
NameUncompress="hisat2"
TestCmd="./hisat2 --help"


CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/VERSION)
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"
PackageVers="v2.2.1-4a411a9"
cd ${PROGPATH}/$PackageName/
#DeleteCreatePath $PROGPATH/$PackageName/$PackageVers
#RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make hisat2-align-s hisat2-build-s hisat2-inspect-s"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts:\$PATH"
AddBashrc "export PYTHONPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/hisat2lib/pymodule:\$PYTHONPATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts"
ModuleAppend "prepend-path    PYTHONPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/hisat2lib/pymodule"

exit 0
