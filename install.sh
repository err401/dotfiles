#!/usr/bin/env bash

chmod +x $(dirname -- "$0")/setup

if ! command -v fish &> /dev/null ;
then
    echo ERROR: fish not installed
else
    /$(dirname -- "$0")/setup $*
fi
