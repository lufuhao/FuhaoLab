#!/bin/bash
source FuhaoLab.conf


PackageName="interproscan"
PackageVers="v5.45-80.0"
InternetLink="ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.45-80.0/interproscan-5.45-80.0-64-bit.tar.gz"
NameUncompress="interproscan-5.45-80.0"
TestCmd="./interproscan.sh -version"   ### return 0
### TestCmd="./interproscan.sh -help" return 1
MACHTYPE="x64"
NameCompress="interproscan-5.45-80.0-64-bit.tar.gz"

CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DownloadWget "ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.45-80.0/interproscan-5.45-80.0-64-bit.tar.gz.md5" "$NameCompress.md5"
Md5Check "$NameCompress.md5"
if [ ! -d $NameUncompress ]; then
	RunCmds "tar -pxzf $NameCompress"
fi
# where:
#     p = preserve the file permissions
#     x = extract files from an archive
#     z = filter the archive through gzip
#     f = use archive file
cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ln -sf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/interproscan.sh ${PROGPATH}/bin/interproscan
DownloadWget "ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-14.1.tar.gz" "panther-data-14.1.tar.gz"
DownloadWget "ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-14.1.tar.gz.md5" "panther-data-14.1.tar.gz.md5"
Md5Check "panther-data-14.1.tar.gz.md5"
RunCmds "tar -pxvzf panther-data-14.1.tar.gz -C ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/data"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi



cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "###$PackageName-$PackageVers"
AddBashrc "export PATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
AddBashrc "export CLASSPATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/interproscan-5.jar:\$CLASSPATH"

exit 0
