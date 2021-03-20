#!/bin/bash
source FuhaoLab.conf

if [ ! -d $PROGPATH/jdk ]; then
	mkdir -p $PROGPATH/jdk
fi
cd $PROGPATH/jdk

declare -a JdkFiles=($(ls jdk-16*_linux-x64_bin.tar.gz ))
if [[ ${#JdkFiles[@]} -lt 1 ]]; then
	PrintInfo "Please visit https://www.oracle.com/java/technologies/javase-downloads.html"
	PrintInfo "Download jdk-16.x.x_linux-x64.tar.gz to this folder: $PROGPATH/jdk"
	exit 100
elif [[ ${#JdkFiles[@]} -gt 1 ]]; then
	PrintInfo "Multiple JDK tar.gz files detected: ${JdkFiles[@]}" >&2
	exit 100
fi





#jdk-16_linux-x64_bin.tar.gz

PackageName="jdk"
NameCompress=${JdkFiles[0]}
TestCmd="./java -version"
PackageVers1=${NameCompress%_linux*}
PackageVers2=${PackageVers1#jdk-}
PackageVers="v$PackageVers2"
PackagePlfm1=${NameCompress#*linux-}
PackagePlfm2=${PackagePlfm1%_bin.tar.gz}
PrintInfo "Version: $PackageVers; Platform: $PackagePlfm2"
if [[ "$PackagePlfm2" == "x64" ]]; then
	PackagePlfm="x64"
elif [[ "$PackagePlfm2" == "i586" ]]; then
	PackagePlfm="x86"
else
	PrintInfo "Error: unknown platform: $PackagePlfm2" >&2
	exit 100
fi
NameUncompress="jdk-$PackageVers2"

CheckPath $PackageName $PackageVers
cd $PROGPATH/$PackageName/$PackageVers
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $PROGPATH/$PackageName/$NameCompress"
fi
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$PackagePlfm"
cd $PROGPATH/$PackageName/$PackageVers/$PackagePlfm/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$PackagePlfm
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export JAVA_HOME=$PROGPATH/$PackageName/$PackageVers/$PackagePlfm"
AddBashrc "export CLASSPATH=.:\${JAVA_HOME}/lib:\$CLASSPATH"
AddBashrc "export PATH=\${JAVA_HOME}/bin:\$PATH"
ModuleAppend "setenv    JAVA_HOME    $PROGPATH/$PackageName/$PackageVers/$PackagePlfm"
ModuleAppend "prepend-path    CLASSPATH    $PROGPATH/$PackageName/$PackageVers/$PackagePlfm/lib"
ModuleAppend "prepend-path    CLASSPATH    ."
ModuleAppend "prepend-path    PATH    $PROGPATH/$PackageName/$PackageVers/$PackagePlfm/bin"

mv $PROGPATH/$PackageName/$NameCompress $PROGPATH/$PackageName/$PackageVers
exit 0
