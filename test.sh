#!/usr/bin/env bash

set -e

TEMP="$(mktemp -d)"

die() {
	local error="${1:-Not Specified}"

	echo "ERROR: ${error}"
	exit 1
}

cleanup() {
	rm -rf "${TEMP}"
	exit 0
}

trap cleanup INT

which nix &>/dev/null || die "Nix is not on path"

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/examples/full"

cd "${ROOT}" || exit 1

NIX="nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes"

${NIX} build --out-link "${TEMP}/result"

cd - || exit 1

mkdir -p "${TEMP}/.local/share"
mkdir -p "${TEMP}/.cache"

export XDG_CONFIG_HOME="${TEMP}/result/home-files/.config"
export XDG_CACHE_HOME="${TEMP}/.cache"
export XDG_DATA_HOME="${TEMP}/.local/share"
export PATH="${TEMP}/result/home-path/bin:${PATH}"

"${TEMP}/result/home-path/bin/nvim"

cleanup
