#!/bin/bash
echo 'Starting to make up your release...'
github-changes $@

echo 'Following lines will be included into release:'
file="./CHANGELOG.md"
skip_line=1
upcoming_regexp="^###[[:space:]]upcoming.*$"
while read -r line; do
    [[ "$line" =~ $upcoming_regexp ]] && skip_line=0 && continue
    [[ $skip_line == 1 ]] && continue
    [[ $skip_line == 0 && -z $line ]] && skip_line=1 && continue
    echo "${line}"
done < "$file"
