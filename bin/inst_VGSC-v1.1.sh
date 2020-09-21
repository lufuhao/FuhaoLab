#!/bin/bash
source FuhaoLab.conf


PackageName="VGSC"
PackageVers="v1.1"
InternetLink="https://sourceforge.net/projects/old-software-collection/files/VGSC.jar"
NameUncompress="bowtie-1.2.3"
TestCmd="java -jar ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar"

if ! CmdExists "java"; then
	PrintError "Error: Please install JAVA/JAVASE first"
	exit 100
fi

#NameCompress="$PackageName-$PackageVers.jar"
CheckPath $PackageName $PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
DownloadWget $InternetLink "VGSC.jar"
DownloadWget "https://sourceforge.net/projects/old-software-collection/files/vgsc-manual.pdf" "vgsc-manual.pdf"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
#$TestCmd
if [ ! -s "${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar" ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
AddBashrc "### VGSC v1.1"
AddBashrc "export VGSC_JAR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar"
AddBashrc "export VGSC_DIR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar:\$CLASSPATH"
ModuleAppend "setenv    VGSC_JAR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar"
ModuleAppend "setenv    VGSC_DIR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/VGSC.jar"

exit 0
