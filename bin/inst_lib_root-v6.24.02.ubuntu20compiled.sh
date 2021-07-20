#!/bin/bash
source FuhaoLab.conf


PackageName="root"
PackageVers="v6.24.02"
InternetLink="https://root.cern/download/root_v6.24.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz"
NameUncompress="root"


NameCompress="$PackageName-$PackageVers.Linux-ubuntu20-x86_64-gcc9.3.tar.gz"
CheckLibPath $PackageName $PackageVers

#:<<EOM

DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
mv ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE

#EOM

#cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX==${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "autoheader"
#RunCmds "autoconf"
#RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "make"
#RunCmds "make test"
#if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
#	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
#fi
#RunCmds "make install"

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "## $PackageName-$PackageVers"
AddBashrc "source ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin/thisroot.sh"
ModuleAppend "source-sh    bash    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin/thisroot.sh"


#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
