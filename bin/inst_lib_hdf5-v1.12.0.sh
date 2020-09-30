#!/bin/bash
source FuhaoLab.conf


PackageName="hdf5"
PackageVers="v1.12.0"
#InternetLink="https://github.com/HDFGroup/hdf5/archive/hdf5-1_12_0.tar.gz"
InternetLink="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz"
NameUncompress="hdf5-1.12.0"

if [ -z "$SZIP_ROOT" ]; then
	PrintError "Error: Please install szip first; and defined SZIP_ROOT to installation path"
	exit 100
fi
NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

exit 0
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE --enable-cxx --with-szlib=$SZIP_ROOT"
RunCmds "make"
RunCmds "make check"
if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
fi
RunCmds "make install"


cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi


cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export HDF5_LIB=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
AddBashrc "export HDF5LIBDIR=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
AddBashrc "export HDF5_INC=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"
AddBashrc "export HDF5INCLUDEDIR=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"
ModuleAppend "setenv    HDF5_LIB    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
ModuleAppend "setenv    HDF5LIBDIR    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
ModuleAppend "setenv    HDF5_INC    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"
ModuleAppend "setenv    HDF5INCLUDEDIR    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"

DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
