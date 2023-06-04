#!/usr/bin/env bash

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cd "${ROOT}" || exit 1

nix build

XDG_CONFIG_HOME="${ROOT}/result/home-files/.config" nvim
