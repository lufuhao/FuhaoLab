#!/bin/bash
source FuhaoLab.conf
#http://hgdownload.cse.ucsc.edu/admin/

PackageName="kent"
PackageVers="v403"
InternetLink="http://hgdownload.cse.ucsc.edu/admin/jksrc.v403.zip"
NameUncompress="kent"
TestCmd="./bowtie --help"

#SoftExist "mysql-server" "uuid-dev"
testMoved=0;

NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "unzip $NameCompress"
fi


cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
PrintInfo "MACHTYPE: $MACHTYPE"
if [ -z "$HOME" ]; then
	exit 100
fi
if [ -d $HOME/bin/$MACHTYPE ]; then
	mv -i $HOME/$MACHTYPE $HOME/$MACHTYPE.old
	testMoved=1;
fi
mkdir -p $HOME/bin/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/lib
RunCmds "make"
if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/lib/$MACHTYPE/jkweb.a ]; then
	PrintError "Error: make libs"
	exit 100
fi

#export MYSQLINC=/usr/include/mysql
#export MYSQLLIBS="/usr/lib/x86_64-linux-gnu/libmysqlclient.a -lz"
#export MYSQLLIBS=" /usr/lib/x86_64-linux-gnu -lmysqlclient -lpthread -lm -lrt -ldl"
#cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/hg/lib
#RunCmds "make"
#if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/lib/$MACHTYPE/jkweb.a ]; then
#	PrintError "Error: make libs"
#	exit 100
#fi


cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/jkOwnLib
RunCmds "make"
if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/lib/$MACHTYPE/jkOwnLib.a ]; then
	PrintError "Error: make jkOwnLib.a"
	exit 100
fi
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/htslib
unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH
RunCmds "make"
if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/htslib/libhts.a ]; then
	PrintError "Error: make jkOwnLib.a"
	exit 100
fi


RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"

RunCmds "make check"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
if [ $testMoved -eq 1 ]; then
	mv -i $HOME/$MACHTYPE.old $HOME/$MACHTYPE
fi
exit 0
