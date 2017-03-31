#!/bin/bash

# check number of parameters
if [[ $# -ne 2 ]]; then
    echo 'Usage:'
    echo './bin2ascii source_directory path_to_out_file'
    exit 1
fi

# does source directory exist?
if [[ ! -d $1 ]]; then
    echo 'input directory does not exist'
    exit 1
fi

# is file name provided
if [[ -d $2 ]]; then
    echo 'provide output file name'
    exit 1
fi

# does output directory exist?
if [[ ! -d `dirname $2` ]]; then
    echo 'output directory does not exist'
    exit 1
fi

# does output file exist?
if [[ -f $2 ]]; then
    read -p 'output file exists, overwrite? [y/N] ' -n 1 -r
    echo
    if [[ ! $REPLY == 'y' ]]; then
        exit 1
    else
        rm $2
    fi
fi

command -v psrtxt >/dev/null 2>&1 || { echo >&2 'psrtxt not found. Please add to PATH'; exit 1; }

for file in $1*.ar
do
    echo $file
    psrtxt $file | awk '{print $3, $4}' >> $2
done
