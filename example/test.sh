#!/usr/bin/env bash

set -e

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cd "${ROOT}" || exit 1

NIX="nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes"

${NIX} flake lock --update-input nightvim
${NIX} build

XDG_CONFIG_HOME="${ROOT}/result/home-files/.config" nvim
