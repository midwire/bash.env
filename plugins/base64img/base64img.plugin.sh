#!/usr/bin/env bash


function base64img() {
    if [[ "${1}" =~ ^(-h|--help) ]]; then
        cat <<'EOF'
Usage: base64img <PATH_TO_IMAGE_FILE>

Note:
base64 content is copied to clipboard using `pbcopy`.

EOF
	return 0
    fi

    local ext
    local raw

    ext="${1##*.}"

    OS=`uname`
    if [[ "$OS" == "Darwin" ]]; then
	raw=$(base64 -i "${1}")
    else 
	raw=$(base64 "${1}")
    fi
    printf 'data:image/%s;base64,%s' "${ext}" "${raw}" | pbcopy &
    wait
    printf '%s\n' "Content in clipboad."

}

## per bpkg guidelines
if [[ ${BASH_SOURCE[0]} != "${0}" ]]; then
    export -f base64img
else
    base64img "${@}"
fi
