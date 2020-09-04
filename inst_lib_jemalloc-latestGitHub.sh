#!/bin/bash
source FuhaoLab.conf
# https://github.com/jemalloc/jemalloc

PackageName="jemalloc"
PackageVersTemp="version"
InternetLink='https://github.com/jemalloc/jemalloc.git'
NameUncompress="jemalloc"
:<<EOM
CheckLibPath $PackageName
cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
EOM
cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
PackageVers="v"$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"



cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
RunCmds "./autogen.sh --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export JEMALLOC_ROOT=$PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"

DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
exit 0
