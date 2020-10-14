#!/bin/bash
source FuhaoLab.conf
#https://github.com/Nextomics/NextDenovo

PackageName="nextDenovo"
PackageVers="v2.3.1"
InternetLink="https://github.com/Nextomics/NextDenovo/releases/download/v2.3.1/NextDenovo.tgz"
NameUncompress="NextDenovo"
TestCmd="./nextDenovo --help"


NameCompress=$PackageName-$PackageVers.tgz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi


cd ${PROGPATH}/$PackageName/$PackageVers/
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
sed -i '1s/python/python3/' nextDenovo
RunCmds "./nextDenovo test_data/run.cfg"



cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export NEXTDENOVO_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddBashrc "export NEXTDENOVO_RUNCFG=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/doc/run.cfg"
ModuleAppend "setenv    NEXTDENOVO_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    NEXTDENOVO_RUNCFG    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/doc/run.cfg"

exit 0
