#!/bin/bash
source FuhaoLab.conf


PythonModules2install="macs3"

if CheckPythonModules $PythonModules2install; then
	echo "Info: $PythonModules2install installed, now checking upgrades"
	pip3 install --user -U macs
else
	pip3 install --user macs
fi

exit 0
