#!/bin/bash
source FuhaoLab.conf


PackageName="repeatmasker"
PackageVers="v4.1.2p1"
InternetLink="http://repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz"
NameUncompress="RepeatMasker"
TestCmd="./RepeatMasker -h"

if [ ! -s ${PROGPATH}/$PackageName/Dfam.h5.gz ]; then
#	wget https://www.dfam.org/releases/Dfam_3.3/families/Dfam.h5.gz
	PrintInfo "Please Download Dfam.h5.gz go to https://www.dfam.org/releases/Dfam_3.*/families"
fi

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

#cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
#RunCmds "make"
#RunCmds "make check"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"

cd ${PROGPATH}/$PackageName

if [ -s ${PROGPATH}/$PackageName/Dfam.h5.gz ]; then
	PrintInfo "Info: using existing Dfam: ${PROGPATH}/$PackageName/Dfam.h5.gz"
	gunzip -c ${PROGPATH}/$PackageName/Dfam.h5.gz > ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/Libraries/Dfam.h5
fi

declare -a RepBaseArr=()
RepBaseArr=($(ls -1 ${PROGPATH}/$PackageName/RepBaseRepeatMaskerEdition-*.tar.gz))
RepBaseFile=""
if [ ${#RepBaseArr[@]} -eq 0 ]; then
	PrintInfo "Downloading RepBaseRepeatMaskerEdition-20181026.tar.gz"
	wget https://sourceforge.net/projects/old-software-collection/files/RepBaseRepeatMaskerEdition-20181026.tar.gz
	if [ $? -ne 0 ] || [ ! -s ${PROGPATH}/$PackageName/RepBaseRepeatMaskerEdition-20181026.tar.gz ]; then
		PrintError "Error: downloading RepBaseRepeatMaskerEdition-20181026.tar.gz"
		exit 100
	fi
	RepBaseFile=${PROGPATH}/$PackageName/RepBaseRepeatMaskerEdition-20181026.tar.gz
else
	RepBaseFile=${RepBaseArr[-1]}
fi
if [ ! -z "$RepBaseFile" ]; then
	if [ -d Libraries ]; then
		rmdir Libraries >/dev/null 2>&1
	fi
	PrintInfo "Info: installing RepBaseRepeatMaskerEdition"
	tar xvf $RepBaseFile
	mv Libraries/* ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/Libraries
	rmdir Libraries >/dev/null 2>&1
fi



if [ ! -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
	ln -sf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/RepeatMasker RepeatMasker
	ln -sf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/RepeatMasker repeatmasker
fi

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

PrintInfo "Info: Now please configure Repeatmasker: 
PrintInfo "      cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/"
PrintInfo "      ./configure"

#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
