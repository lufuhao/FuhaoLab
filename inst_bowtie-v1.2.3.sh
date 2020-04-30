#!/bin/bash
source FuhaoLab.conf


PackageName="bowtie"
PackageVers="v1.2.3"
InternetLink="https://github.com/BenLangmead/bowtie/archive/v1.2.3.tar.gz"
NameUncompress="bowtie-1.2.3"



NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath bowtie v1.2.3
DownloadWget $InternetLink $NameCompress
tar xzvf $NameCompress
cd $NameUncompress
make
make prefix=$PWD/../x86_64 install
cd $PWD/../x86_64/bin
./bowtie
if [ $? -ne 0 ]; then
	echo "Info: if you want it in effect immediately"
	echo "export PATH=$PWD:\$PATH"
	echo "Info: adding to PATH to ~/.bashrc"
	echo "### $PackageName-$PackageVers" >> ~/.bashrc
	echo "export PATH=$PWD:\$PATH" >> ~/.bashrc
else
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
