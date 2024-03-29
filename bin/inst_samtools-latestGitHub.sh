#!/bin/bash
source FuhaoLab.conf
#https://github.com/samtools/samtools

PackageName="samtools"
PackageVersTemp="version"
InternetLink='samtools/samtools.git'
NameUncompress="samtools"
TestCmd="./samtools --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
configureOptions=""
if [ ! -z "$HTSDIR" ]; then
	configureOptions=" ${configureOptions} --with-htslib $HTSDIR "
else
	git clone --recursive ${GITHUB_CUSTOM_SITE}/samtools/htslib.git
	if [ $? -ne 0 ]; then
		echo "Error: failed to download HTSlib" >&2
		exit 100
	fi
fi



cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers="v"$(grep ^'VERSION=' version.sh | sed 's/^.*=//')
#PrintInfo "Version: $PackageVers"
PackageVers="v"$(git describe --match '[0-9].[0-9]*' --dirty --always)
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "autoheader"
RunCmds "autoconf -Wno-syntax"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $configureOptions "
#RunCmds "make all all-htslib"
RunCmds "make all"
RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install install-htslib"
RunCmds "make prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include
RunCmds "cp *.h ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include"
if [ -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include/version.h ]; then
	rm ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include/version.h
fi
if [ -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include/config.h ]; then
	rm ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include/config.h
fi
RunCmds "cp *.a ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

AddBashrc "export SAMTOOLS_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleInfo " module load htslib samtools"
ModuleAppend "prereq    htslib"
ModuleAppend "setenv    SAMTOOLS_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"


DeletePath ${PROGPATH}/$PackageName/$NameUncompress
DeletePath ${PROGPATH}/$PackageName/htslib
exit 0
