#!/bin/bash

files=$(git diff --cached --name-only --diff-filter=AM | grep -E .'js|html|css|json'$)
pass=true

autofix=$1

if [ "$files" != "" ]; then
    for file in ${files}; do
        result=$(eslint ${file} -f stylish ${autofix})

        if [ "$result" != "" ]; then
            echo "$result"
            echo "\n"
            pass=false
        fi
    done
fi

read -p "Press any key..."

if $pass; then
    exit 0
else
    echo ""
    echo "COMMIT FAILED:"
    echo "Some JavaScript files are invalid. Please fix errors and try committing again."
    exit 1
fi

done