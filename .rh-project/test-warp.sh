#!/bin/bash

set -eu
set -o pipefail

ulimit -c unlimited

SDPATH="$(dirname "${BASH_SOURCE[0]}")"
if [ ! -d "${SDPATH}" ]; then SDPATH="${PWD}"; fi
readonly SDPATH="$(cd -P "${SDPATH}" && pwd)"

# shellcheck source=./conf.sh
source "${SDPATH}/conf.sh"

cd "${PRJ_ROOT_PATH}"; echo cd "${PWD}"

# export BOOST_TEST_LOG_LEVEL=all

echo
CMD=(bazel)
CMD+=("${BAZEL_RUN_CMD[@]}")
CMD+=("${BAZEL_DEBUG_CMD[@]}")
CMD+=("${BAZEL_TERM_CMD[@]}")
CMD+=(//packages/warp:warp_test -- --log_level=all)
CMD+=('2>&1')
echo + "${CMD[@]}" && eval "${CMD[@]}"
