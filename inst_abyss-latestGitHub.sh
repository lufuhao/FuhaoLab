#!/bin/bash
source FuhaoLab.conf


PackageName="abyss"
PackageVersTemp="version"
InternetLink='https://github.com/bcgsc/abyss'
NameUncompress="abyss"
TestCmd="./ABYSS --help"
#PackageVers="v2.2.4-5ae4e481"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT(ABySS, 2.2.4, abyss-users@bcgsc.ca, abyss,
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT(ABySS,\s\+//;s/,.*$//g')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "./autogen.sh"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --enable-maxk=256"
RunCmds "make"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export TMPDIR=/var/tmp"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
