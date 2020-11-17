#!/bin/bash
source FuhaoLab.conf


PackageName="miniconda3"
PackageVers="version"
InternetLink="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh"
#NameUncompress="htslib-1.10.2"

CreatePath ${PROGPATH}/libraries/$PackageName
cd ${PROGPATH}/libraries/$PackageName
NameCompress="Miniconda3-latest-Linux-x86_64.sh"
DownloadWget $InternetLink $NameCompress
PackageVers="v"$(bash ${PROGPATH}/libraries/$PackageName/Miniconda3-latest-Linux-x86_64.sh  -h | grep ^'Installs Miniconda3' | sed 's/^.*\s\+//g;s/py[0-9]\+_//g;')
PrintInfo "Version: $PackageVers"
CheckLibPath $PackageName $PackageVers
CreatePath ${PROGPATH}/libraries/$PackageName/$PackageVers
RunCmds "mv ${PROGPATH}/libraries/$PackageName/Miniconda3-latest-Linux-x86_64.sh ${PROGPATH}/libraries/$PackageName/$PackageVers/"


cd ${PROGPATH}/libraries/$PackageName/$PackageVers/
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "bash Miniconda3-latest-Linux-x86_64.sh  -b -p ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"


cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin
./conda --version
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi
#./conda init

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
