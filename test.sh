#!/usr/bin/env bash

set -e

EXAMPLE="${1:-full}"

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/examples/${EXAMPLE}"

cd "${ROOT}" || exit 1

NIX="nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes"

${NIX} flake lock --update-input nightvim
${NIX} build

cd - || exit 1

XDG_CONFIG_HOME="${ROOT}/result/home-files/.config" "${ROOT}/result/home-path/bin/nvim"
