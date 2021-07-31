#!/bin/bash
source FuhaoLab.conf


PackageName="root"
PackageVersTemp="version"
InternetLink='root-project/root.git'
NameUncompress="root"

CheckLibPath $PackageName


cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi



cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty | sed -e 's/-[0-9]\+-g//')
#PrintInfo "Version: $PackageVers"

#EOM

exit 0
cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
DeletePath ${PROGPATH}/libraries/$PackageName/build
CreatePath ${PROGPATH}/libraries/$PackageName/build
cd ${PROGPATH}/libraries/$PackageName/$NameUncompress/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ../root"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "cmake --build . -- install j4"
#RunCmds "make install"

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

#DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress/build
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
exit 0
