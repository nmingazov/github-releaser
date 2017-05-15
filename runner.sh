#!/bin/bash
echo 'Starting to make up your release...'
github-changes $@

file="./CHANGELOG.md"
skip_line=1
upcoming_regexp="^###[[:space:]]upcoming.*$"
result=
while read -r line; do
    [[ "${line}" =~ ${upcoming_regexp} ]] && skip_line=0 && continue
    [[ ${skip_line} == 1 ]] && continue
    [[ ${skip_line} == 0 && -z $line ]] && skip_line=1 && continue
    result="${result}${line}"
done < "${file}"

if [[ -z ${result} ]]; then
    echo 'Nothing to include into release. Exiting..'
    exit
else
    echo 'Following lines will be included into release:'
    echo ${result}
fi
