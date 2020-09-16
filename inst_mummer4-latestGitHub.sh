#!/bin/bash

#http://mummer4.github.io
source FuhaoLab.conf


PackageName="mummer4"
PackageVersTemp="version"
InternetLink='https://github.com/mummer4/mummer.git'
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
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*MUMmer\], \[//;s/\].*$//g')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress
if [ ! -s ${PROGPATH}/$PackageName/$NameUncompress/configure ]; then
	RunCmds "autoreconf -fi"
fi
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make install"

if [ ! -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
if [ -s $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/mummerplot ]; then
	sed -i '1c #!/usr/bin/env perl' $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/mummerplot
fi


cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
