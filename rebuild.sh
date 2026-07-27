#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles
nix run home-manager -- switch --flake ~/.dotfiles#danie

cd "$DIR"
git add .
git commit -m "${1:-update}"
git push
