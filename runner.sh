#!/bin/bash

owner=
repo=
# based on FAQ http://mywiki.wooledge.org/BashFAQ/035
while :; do
    case $1 in
        -o|--owner)       # Provides owner as "-o <owner>" or "--owner <owner>"
            if [ -n "$2" ]; then
                owner=$2
                shift
            else
                printf 'ERROR: "--owner" requires a non-empty option argument.\n' >&2
            fi
            ;;
        --owner=?*)       # Provides owner as "--owner=<owner>"
            owner=${1#*=}
            ;;
        --owner=)         # Checks explicitly for empty case
            printf 'ERROR: "--owner" requires a non-empty option argument.\n' >&2
            exit
            ;;
        -r|--repo)        # Provides repo as "-r <repo>" or "--repo <repo>"
            if [ -n "$2" ]; then
                repo=$2
                shift
            else
                printf 'ERROR: "--repo" requires a non-empty option argument.\n' >&2
            fi
            ;;
        --repo=?*)        # Provides repo as "--repo=<repo>"
            repo=${1#*=}
            ;;
        --repo=)          # Checks explicitly for empty case
            printf 'ERROR: "--repo" requires a non-empty option argument.\n' >&2
            exit
            ;;
        --)                # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)                # Default case: If no more options then break out of the loop.
            break
    esac
    shift
done

echo 'Starting to make up your release. Beware: there could be some lags after you entered password! Give it a minute.'
github-changes -a --only-pulls --use-commit-body -o ${owner} -r ${repo}

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
    echo 'Nothing to include into release.'
else
    echo 'Following lines should be included into release:'
    echo ${result}
fi
