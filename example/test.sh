#!/usr/bin/env bash

set -e

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cd "${ROOT}" || exit 1

nix flake lock --update-input nightvim
nix build

XDG_CONFIG_HOME="${ROOT}/result/home-files/.config" nvim
