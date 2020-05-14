#!/bin/bash
source FuhaoLab.conf

#sudo apt-get install python-pip python3-pip python-setuptools python3-setuptools
#sudo pip3 install cython

PackageName="cutadapt"
PackageVers="v2.10"
InternetLink="https://github.com/marcelm/cutadapt/archive/v2.10.tar.gz"
NameUncompress="cutadapt-2.10"
TestCmd="cutadapt --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
python3 setup.py build
python3 setup.py install --user
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

exit 0
