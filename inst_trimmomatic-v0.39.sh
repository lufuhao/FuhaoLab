#!/bin/bash
#http://www.usadellab.org/cms/?page=trimmomatic
source FuhaoLab.conf


PackageName="trimmomatic"
PackageVers="v0.39"
InternetLink="http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip"
NameUncompress="Trimmomatic-0.39"
#TestCmd="java -jar trimmomatic-0.39.jar -version"
TestCmd="java org.usadellab.trimmomatic.TrimmomaticPE"


NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress

if [ ! -d $PROGPATH/$PackageName/$PackageVers/x86_64 ]; then
	if [ ! -d $NameUncompress ]; then
		RunCmds "unzip $NameCompress"
	else
		mv $NameUncompress x86_64
	fi
fi
cd $PROGPATH/$PackageName/$PackageVers/x86_64
java -classpath ${PROGPATH}/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar org.usadellab.trimmomatic.TrimmomaticPE -version
if [ $? -ne 0 ]; then
	PrintInfo "Warnings: failed to run classpath $PackageName-$PackageVers"
	exit 100
fi
if [ -s $PROGPATH/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar ]; then
	AddBashrc "### $PackageName-$PackageVers"
	AddBashrc "export PATH_TTRIMMOMATIC_ROOT=\${PROGPATH}/$PackageName/$PackageVers/x86_64"
	AddBashrc "export PATH_TTRIMMOMATIC_ADAPTERS=\${PROGPATH}/$PackageName/$PackageVers/x86_64/adaptors"
	AddBashrc "export PATH_TRIMMOMATIC_JAR=\${PROGPATH}/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar"
	AddBashrc "export CLASSPATH=\${PROGPATH}/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar:\$CLASSPATH"
fi

exit 0
