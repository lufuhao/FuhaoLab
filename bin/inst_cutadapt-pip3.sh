#!/bin/bash
source FuhaoLab.conf


PythonModules2install="cutadapt"

if CheckPythonModules $PythonModules2install; then
	echo "Info: PythonModules2install installed, now checking upgrades"
	pip3 install --user -U cutadapt
else
	pip3 install --user cutadapt
fi

exit 0
