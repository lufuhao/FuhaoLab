#!/bin/bash
source FuhaoLab.conf
#https://www.lirmm.fr/~rivals/lordec/
#https://github.com/GATB/gatb-core/archive/v1.4.1.tar.gz
#https://kent.dl.sourceforge.net/project/boost/boost/1.64.0/boost_1_64_0.tar.gz


PackageName="LoRDEC"
PackageVers="v0.9"
InternetLink="https://gite.lirmm.fr/lordec/lordec-releases/uploads/800a96d81b3348e368a0ff3a260a88e1/lordec-src_0.9.tar.bz2"
NameUncompress="lordec-src_0.9"
TestCmd="./lordec-correct -h"
##--help retrurn 1

SoftExist "zlib1g-dev"
### will automatically download libboost
#SoftExist "libboost-dev"

NameCompress=$PackageName-$PackageVers.tar.bz2
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "make clean all -j8"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE HPC_SCRIPT=lordec_sge_slurm_wrapper.sh install"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
