#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVersTemp="version"
InternetLink='git@github.com:samtools/htslib.git'
NameUncompress="htslib"

CheckLibPath $PackageName

#:<<EOM
cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --always --tags --dirty)
PrintInfo "Version: $PackageVers"

#EOM
exit 0

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

#EOM

cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"



#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
