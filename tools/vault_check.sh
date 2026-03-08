#! /usr/bin/env bash

# Check that given file is an encrypted ansible vault file.
# A valid vault file starts with the $ANSIBLE_VAULT; string.
must-be-encrypted() {
    local file="$1"
    local header="$(head -n1 "$file")"

    if [[ "$header" != \$ANSIBLE_VAULT\;* ]]; then
        >&2 printf 'Unencrypted vault file: %s\n' "$file"
        echo 1 >> "$fail"
    fi
}

main() {
    export fail="$(mktemp)"
    export -f must-be-encrypted

    # Find all files with
    find . -type f -name '*.vault.yml' -exec bash -c 'must-be-encrypted "{}"' \;

    local failed_num="$(wc -l < "$fail")"
    if (( failed_num > 0 )); then
        >&2 printf 'Found %d unencrypted vault files\n' "$failed_num"
        exit 1
    fi

    printf "All vault files are encrypted\n"
}

main
