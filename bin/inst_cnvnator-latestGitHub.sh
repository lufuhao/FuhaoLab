#!/bin/bash
source FuhaoLab.conf


PackageName="cnvnator"
PackageVersTemp="version"
InternetLink='abyzovlab/CNVnator.git'
NameUncompress="CNVnator"
TestCmd="./cnvnator --help"
#PackageVers=""

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/
git clone --recursive ${GITHUB_CUSTOM_SITE}/samtools/htslib.git
#cd ${PROGPATH}/$PackageName/htslib
#RunCmds "autoheader"
#RunCmds "autoconf"
#RunCmds "./configure"
#RunCmds "make"

cd ${PROGPATH}/$PackageName
git clone ${GITHUB_CUSTOM_SITE}/samtools/samtools.git
cd ${PROGPATH}/$PackageName/samtools
RunCmds "autoheader"
RunCmds "autoconf -Wno-syntax"
RunCmds "./configure"
RunCmds "make all all-htslib"

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

RunCmds "make SAMDIR=${PROGPATH}/$PackageName/samtools HTSDIR=${PROGPATH}/$PackageName/htslib"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
#$TestCmd
if [ ! -s "${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/cnvnator" ] || [ ! -x "${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/cnvnator" ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
