#!/bin/bash
source FuhaoLab.conf


PythonModules2install="deeptools"

if CheckPythonModules $PythonModules2install; then
	echo "Info: $PythonModules2install installed, now checking upgrades"
	pip3 install --user -U deepTools
else
	pip3 install --user deepTools
fi

exit 0
