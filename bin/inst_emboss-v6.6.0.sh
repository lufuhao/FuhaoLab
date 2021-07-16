#!/bin/bash
source FuhaoLab.conf


PackageName="emboss"
PackageVers="v6.6.0"
InternetLink="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-6.6.0.tar.gz"
NameUncompress="EMBOSS-6.6.0"
TestCmd="./embossversion"

if [ -z "$JAVA_HOME" ]; then
	PrintError "Error: need to define JAVA_HOME or install JDK first"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
sed -i -e '72c \    bcopy(src, dst, len);' -e '73i \    return;' ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/ajax/core/ajstr.c
if [ -d $JAVA_HOME/include ]; then
	export C_INCLUDE_PATH=$JAVA_HOME/include:$C_INCLUDE_PATH
	export CPLUS_INCLUDE_PATH=$JAVA_HOME/include:$CPLUS_INCLUDE_PATH
fi
if [ -d $JAVA_HOME/include/linux ]; then
	export C_INCLUDE_PATH=$JAVA_HOME/include/linux:$C_INCLUDE_PATH
	export CPLUS_INCLUDE_PATH=$JAVA_HOME/include/linux:$CPLUS_INCLUDE_PATH
fi
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --enable-shared --enable-static --enable-warnings --enable-large --enable-mcheck --with-x --with-java=$JAVA_HOME --with-thread "
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --enable-shared --enable-static --enable-large --with-thread "
RunCmds "make"
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
exit 0
