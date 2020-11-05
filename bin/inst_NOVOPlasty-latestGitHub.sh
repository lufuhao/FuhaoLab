#!/bin/bash
source FuhaoLab.conf


PackageName="NOVOPlasty"
PackageVersTemp="version"
InternetLink='https://github.com/ndierckx/NOVOPlasty.git'
NameUncompress="NOVOPlasty"
TestCmd="perl ./NOVOPlasty4.2.pl --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1 | sed 's/NOVOPlasty/v/')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
FileArr=$(ls ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/NOVOPlasty*.pl)
if [ ${FileArr[@]} -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
chmod +x ${FileArr[0]}

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export NOVOPLASTY_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    NOVOPLASTY_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

exit 0
