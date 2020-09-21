#!/bin/bash
#https://github.com/gmarcais/Jellyfish
source FuhaoLab.conf


PackageName="jellyfish"
PackageVersTemp="version"
InternetLink='https://github.com/gmarcais/Jellyfish.git'
NameUncompress="Jellyfish"
TestCmd="./jellyfish --version"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
### AC_INIT([jellyfish], [2.3.0], [gmarcais@umd.edu])
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "autoreconf -i"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make -j4"
RunCmds "make install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
