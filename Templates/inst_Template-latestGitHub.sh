#!/bin/bash
source FuhaoLab.conf


PackageName="mummer4"
PackageVersTemp="version"
InternetLink='git@github.com:mummer4/mummer.git'
NameUncompress="mummer"
TestCmd="./bowtie --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress

RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

rm -rf ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress

exit 0
