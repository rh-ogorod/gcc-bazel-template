#!/bin/bash

set -eu
set -o pipefail

SDPATH="$(dirname "${BASH_SOURCE[0]}")"
if [ ! -d "${SDPATH}" ]; then SDPATH="${PWD}"; fi
readonly SDPATH="$(cd -P "${SDPATH}" && pwd)"

# shellcheck source=./conf.sh
source "${SDPATH}/conf.sh"

cd "${PRJ_ROOT_PATH}"; echo + cd "${PWD}"

echo
CMD=(bazel)
CMD+=("${BAZEL_BUILD_CMD[@]}")
CMD+=("${BAZEL_DEBUG_CMD[@]}")
CMD+=("${BAZEL_TERM_CMD[@]}")
CMD+=(//packages/warp)
echo + "${CMD[@]}" && "${CMD[@]}"
