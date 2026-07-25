#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating apt package lists"
sudo apt update

echo "==> Installing system dependencies (build tools, WezTerm/WSLg graphics libs)"
sudo apt install -y \
  build-essential \
  bubblewrap \
  libegl1 \
  mesa-utils \
  libglx-mesa0

echo "==> Checking for Nix"
if ! command -v nix &> /dev/null; then
  echo "Nix not found. Installing (Determinate Systems installer)..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
else
  echo "Nix already installed, skipping."
fi

echo "==> Checking for Homebrew (Linuxbrew)"
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping."
fi

echo ""
echo "==> Bootstrap complete."
echo "Next steps:"
echo "  1. Restart your shell (or run: exec zsh) so Nix and Homebrew are on your PATH"
echo "  2. Run: brew install herdr"
echo "  3. Run: ./rebuild.sh \"initial setup\""
