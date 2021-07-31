#!/bin/bash
source FuhaoLab.conf
###https://github.com/steuernb/NLR-Annotator/releases
### for MEME <=4.9.1

PackageName="NLRannotator"
PackageVers="v0.7beta9281f70"
TestCmd="java -jar NLR-Annotator.jar --help"

CheckPath $PackageName $PackageVers/
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
DownloadWget ${GITHUB_CUSTOM_SITE}/steuernb/NLR-Annotator/releases/download/v0.7-beta/ChopSequence.jar ChopSequence.jar
DownloadWget ${GITHUB_CUSTOM_SITE}/steuernb/NLR-Annotator/releases/download/v0.7-beta/meme.xml meme.xml
DownloadWget ${GITHUB_CUSTOM_SITE}/steuernb/NLR-Annotator/releases/download/v0.7-beta/NLR-Annotator.jar NLR-Annotator.jar
DownloadWget ${GITHUB_CUSTOM_SITE}/steuernb/NLR-Annotator/releases/download/v0.7-beta/NLR-Parser.jar NLR-Parser.jar

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### NLR-Annotator; needs MEME <=4.9.1"
AddBashrc "export NLR_ANNOTATOR_HOME=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$CLASSPATH"
ModuleAppend "setenv    NLR_ANNOTATOR_HOME    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

exit 0
