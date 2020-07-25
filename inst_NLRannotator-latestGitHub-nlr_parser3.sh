#!/bin/bash
source FuhaoLab.conf
###needs MEME >5.1

PackageName="NLRannotator"
PackageVersTemp="version"
InternetLink='https://github.com/steuernb/NLR-Annotator.git'
NameUncompress="NLR-Annotator"
TestCmd="java -jar ./NLR-Annotator.jar --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone -b nlr_parser3 $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
DownloadWget https://github.com/steuernb/NLR-Parser/raw/master/meme.xml meme.xml
#DownloadWget https://github.com/steuernb/NLR-Annotator/releases/download/v0.7-beta/meme.xml meme.xml
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')".nlr_parser3"
PrintInfo "Version: $PackageVers"


cd ${PROGPATH}/$PackageName
DeletePath $PROGPATH/$PackageName/$PackageVers
RunCmds "mkdir -p $PROGPATH/$PackageName/$PackageVers"
mv ${PROGPATH}/$PackageName/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### NLR-Annotator; needs MEME >5.1"
AddBashrc "export NLR_ANNOTATOR_HOME=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddBashrc "export CLASSPATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$CLASSPATH"

exit 0
