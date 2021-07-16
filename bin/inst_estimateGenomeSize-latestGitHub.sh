#!/bin/bash
source FuhaoLab.conf


PackageName="estimate_genome_size"
PackageVersTemp="version"
InternetLink='https://github.com/josephryan/estimate_genome_size.pl.git'
NameUncompress="estimate_genome_size.pl"
TestCmd="./estimate_genome_size.pl --help"
#PackageVers=""
:<<EOM
CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
EOM
cd ${PROGPATH}/$PackageName/$NameUncompress
#              VERSION   => '0.03',
PackageVers="v"$(grep 'VERSION' ${PROGPATH}/$PackageName/$NameUncompress/Makefile.PL | sed "s/^.*VERSION.*=>\s\+'//;s/'.*$//")"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
if [ -z "$INSTALL_BASE" ]; then
	RunCmds "perl Makefile.PL PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	RunCmds "make"
	DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
	RunCmds "make install"
else
	RunCmds "perl Makefile.PL"
	RunCmds "make"
	DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
	RunCmds "make INSTALL_BASE=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
fi
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
chmod u+w *.pl
PerlUpdateHeader *.pl

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
AddBashrc "export MANPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/man:\$MANPATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
ModuleAppend "prepend-path    MANPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/man"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
