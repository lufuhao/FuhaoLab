#!/bin/bash
source FuhaoLab.conf


PackageName="ray"
PackageVersTemp="version"
InternetLink='https://github.com/sebhtml/ray.git'
NameUncompress="ray"
TestCmd="./Ray --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

git clone https://github.com/sebhtml/RayPlatform.git
if [ $? -ne 0 ]; then
	echo "Error: failed to download RayPlatform" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make MPI_IO=y PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE MAXKMERLENGTH=251 HAVE_LIBZ=y HAVE_LIBBZ2=y ASSERT=n FORCE_PACKING=y"
RunCmds "make install"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
