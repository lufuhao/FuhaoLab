#!/bin/bash
source FuhaoLab.conf


PythonModules2install="nanopack"

if CheckPythonModules $PythonModules2install; then
	echo "Info: $PythonModules2install installed, now checking upgrades"
	pip3 install --user -U $PythonModules2install
else
	pip3 install --user $PythonModules2install
fi

exit 0
