#!/bin/bash
#https://github.com/primer3-org/primer3
source FuhaoLab.conf


PackageName="primer3"
PackageVersTemp="version"
InternetLink='primer3-org/primer3.git'
NameUncompress="primer3"
TestCmd="./primer3_core --help"
#return 255

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#release 2.5.0 2019-08-17  ===============================================
PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/src/release_notes.txt | cut -f 2 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress/src
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
if [ ! -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	echo "Error: failed to make $PackageName-$PackageVers" >&2
	exit 100
fi
cp -R ${PROGPATH}/$PackageName/$NameUncompress/src/primer3_config ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
if [ ! -x $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_core ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export PRIMER_THERMODYNAMIC_PARAMETERS_PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_config"
ModuleAppend "setenv    PRIMER_THERMODYNAMIC_PARAMETERS_PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_config"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
