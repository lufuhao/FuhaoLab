#!/bin/bash
#http://www.usadellab.org/cms/?page=trimmomatic
source FuhaoLab.conf


PackageName="trimmomatic"
PackageVers="v0.39"
InternetLink="http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip"
NameUncompress="Trimmomatic-0.39"
TestCmd="java -jar trimmomatic-0.39.jar -version"


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
if [ -s $PROGPATH/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar ]; then
	echo "export PATH_TRIMMOMATIC_JAR=$PROGPATH/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar"
	export PATH_TRIMMOMATIC_JAR=$PROGPATH/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar
	echo "### $PackageName-$PackageVers" >> ${HOME}/.bashrc
	echo "export PATH_TRIMMOMATIC_JAR=$PROGPATH/$PackageName/$PackageVers/x86_64/trimmomatic-0.39.jar" >> ${HOME}/.bashrc
else
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
