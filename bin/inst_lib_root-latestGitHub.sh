#!/bin/bash
source FuhaoLab.conf


PackageName="root"
PackageVersTemp="version"
InternetLink='root-project/root.git'
NameUncompress="root"
PackageVers="v6.25.01-0173f51a8c"

CheckLibPath $PackageName

:<<EOM
cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone --branch latest-stable ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
#EOM


cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1 | sed 's/-/./g;')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty | sed -e 's/-[0-9]\+-g//')
#PrintInfo "Version: $PackageVers"

EOM


cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
:<<EOM2
DeletePath ${PROGPATH}/libraries/$PackageName/build
CreatePath ${PROGPATH}/libraries/$PackageName/build
cd ${PROGPATH}/libraries/$PackageName/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ../root"
EOM2
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
CreatePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "cmake --build . -- install j4"
#RunCmds "make install"

exit 0
cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

#EOM

cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "source ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin/thisroot.sh"
ModuleAppend "source-sh    bash    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin/thisroot.sh"

DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress/build
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
exit 0
