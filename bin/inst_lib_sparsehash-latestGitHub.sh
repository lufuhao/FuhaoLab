#!/bin/bash
source FuhaoLab.conf


PackageName="sparsehash"
PackageVersTemp="version"
InternetLink='https://github.com/sparsehash/sparsehash.git'
NameUncompress="sparsehash"
PackageVers="v2.0.4-1dffea3"

CheckLibPath $PackageName
cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
###AC_INIT(sparsehash, 2.0.2, google-sparsehash@googlegroups.com)
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/libraries/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*sparsehash, //;s/, .*$//g')"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1 | sed 's/sparsehash-/v/;')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
RunCmds "./autogen.sh"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make check"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
ModuleAppend "setenv    SPARSEHASH_ROOT    $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"

DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
exit 0
