#!/bin/bash
source FuhaoLab.conf


PackageName="pilon"
PackageVers="v1.23"
InternetLink="${GITHUB_CUSTOM_SITE}/broadinstitute/pilon/releases/download/v1.23/pilon-1.23.jar"
#NameUncompress="bowtie-1.2.3"
TestCmd="java -jar pilon-v1.23.jar --help"

NameCompress=$PackageName-$PackageVers.jar
CheckPath $PackageName $PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
DownloadWget $InternetLink $NameCompress

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$CLASSPATH"
AddBashrc "export PILON_JAR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/pilon-1.23.jar"
ModuleAppend "setenv    PILON_JAR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/pilon-1.23.jar"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
