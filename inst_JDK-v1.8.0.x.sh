#!/bin/bash
source FuhaoLab.conf

if [ ! -d $PROGPATH/jdk ]; then
	mkdir -p $PROGPATH/jdk
fi
cd $PROGPATH/jdk

declare -a JdkFiles=($(ls jdk-8u*-linux-*.tar.gz ))
if [[ ${#JdkFiles[@]} -lt 1 ]]; then
	PrintInfo "Please visit https://www.oracle.com/java/technologies/javase-downloads.html"
	PrintInfo "Download jdk-xxxx-linux-xxx.tar.gz to this folder: $PROGPATH/jdk"
	exit 100
elif [[ ${#JdkFiles[@]} -gt 1 ]]; then
	PrintInfo "Multiple JDK tar.gz files detected: ${JdkFiles[@]}" >&2
	exit 100
fi





#jdk-8u251-linux-x64.tar.gz
#jdk-8u251-linux-i586.tar.gz

PackageName="jdk"
NameCompress=${JdkFiles[0]}
TestCmd="./java -version"
PackageVers1=${NameCompress%-linux*}
PackageVers2=${PackageVers1#jdk-8u}
PackageVers="v1.8.0.$PackageVers2"
PackagePlfm1=${NameCompress#*linux-}
PackagePlfm2=${PackagePlfm1%.tar.gz}
if [[ "$PackagePlfm2" == "x64" ]]; then
	PackagePlfm="x64"
elif [[ "$PackagePlfm2" == "i586" ]]; then
	PackagePlfm="x86"
else
	PrintInfo "Error: unknown platform: $PackagePlfm2" >&2
	exit 100
fi
NameUncompress="jdk1.8.0_$PackageVers2"

CheckPath $PackageName $PackageVers
cd $PROGPATH/$PackageName/$PackageVers
#if [ ! -d $NameUncompress ]; then
#	RunCmds "tar xzvf $PROGPATH/$PackageName/$NameCompress"
#fi
#RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$PackagePlfm"
cd $PROGPATH/$PackageName/$PackageVers/$PackagePlfm/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$PackagePlfm
AddBashrc "### JDK $PackageName-$PackageVers"
AddBashrc "export JAVA_HOME=$PROGPATH/$PackageName/$PackageVers/$PackagePlfm"
AddBashrc "export JRE_HOME=\${JAVA_HOME}/jre"
AddBashrc "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib:\$CLASSPATH"
AddBashrc "export JAVA_PATH=\${JAVA_HOME}/bin:\${JRE_HOME}/bin"
AddBashrc "export PATH=\${JAVA_PATH}:\$PATH"

mv $PROGPATH/$PackageName/$NameCompress $PROGPATH/$PackageName/$PackageVers
exit 0
