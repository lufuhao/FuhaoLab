#!/bin/bash
source FuhaoLab.conf
#https://github.com/biod/sambamba

PackageName="sambamba"
PackageVersTemp="version"
InternetLink='biod/sambamba.git'
NameUncompress="sambamba"
TestCmd="./sambamba markdup -h"

if ! CmdExists ldc2; then
	PrintError "Error: please install LDC first using inst_ldc-xxxx.sh"
	exit 100
fi

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone --recursive ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/VERSION | sed 's/\s\+.*$//g')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress

unset C_INCLUDE_PATH
unset CPLUS_INCLUDE_PATH
RunCmds "make"
#RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"
declare -a BinArr=($(find ${PROGPATH}/$PackageName/$NameUncompress/bin/ -perm /+x -name "sambamba-*" -type f))
if [[ ${#BinArr[@]}  -eq 1 ]]; then
#	mv ${BinArr[0]} ${PROGPATH}/$PackageName/$NameUncompress/bin/sambamba
	mv ${BinArr[0]} $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/sambamba
else
	PrintError "Error: unknow how to find sambamba: please check ${PROGPATH}/$PackageName/$NameUncompress/bin/sambamba-*"
	exit 100
fi

#RunCmds "make prefix=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/ install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
