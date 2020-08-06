#!/bin/bash
source FuhaoLab.conf
### https://github.com/igvteam/igv


PackageName="igv"
PackageVersTemp="version"
InternetLink='https://github.com/igvteam/igv.git'
NameUncompress="igv"

:<<EOH
CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
EOH
cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "./gradlew createDist"
RunCmds "./gradlew test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d $PROGPATH/$PackageName/$PackageVers ]; then
	mkdir -p $PROGPATH/$PackageName/$PackageVers
fi
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress/build/IGV-dist $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
if [ ! -x igv.sh ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
ln -sf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/igv.sh ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/igv
AddBashrc "### $PackageName-$PackageVers Building from source"
AddBashrc "export PATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
