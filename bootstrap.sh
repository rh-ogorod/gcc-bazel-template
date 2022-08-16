#!/bin/bash

# TODO: install sshpass

set -eu
set -o pipefail

SDPATH="$(dirname "${BASH_SOURCE[0]}")"
if [[ ! -d "${SDPATH}" ]]; then SDPATH="${PWD}"; fi
readonly SDPATH="$(cd -P "${SDPATH}" && pwd)"

PRJ_ROOT_PATH="${SDPATH}"
readonly PRJ_ROOT_PATH="$(cd "${PRJ_ROOT_PATH}" && pwd)"

cd "${PRJ_ROOT_PATH}"; echo + cd "${PWD}"

CMD=(./.rh-project/git-populate-submodules.sh)
echo + "${CMD[@]}" && "${CMD[@]}"

echo
CMD=(yarn)
echo + "${CMD[@]}" && "${CMD[@]}"

echo
(cd ./.rh-project; echo cd "${PWD}"
 CMD=(./generate-compdb.sh)
 echo + "${CMD[@]}" && "${CMD[@]}")
