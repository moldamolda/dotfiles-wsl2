# molda-dotfiles

Personal dotfiles setup for WSL (Ubuntu), managed with [Nix](https://nixos.org) and [Home Manager](https://github.com/nix-community/home-manager).

## What this repo does

Running `./rebuild.sh` sets up/updates the following:

- CLI tools via Nix: `ripgrep`, `fd`, `fzf`, `jq`, `lazygit`, `neovim`, `claude-code`
- Shell: `zsh` with Homebrew shell integration
- Editor: `nvim` as the default `$EDITOR`

## Prerequisites (manual, one-time setup on a fresh machine)

These cannot be managed by Nix/Home Manager and must be installed manually before `./rebuild.sh` can run:

### 1. WSL + Ubuntu
Must already be installed and updated (`sudo apt update && sudo apt upgrade`).

### 2. Nix (Determinate Systems installer)
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 3. Home Manager
```bash
nix run home-manager -- switch --flake .#molda
```
(First time only, see "Getting started" below.)

### 4. Homebrew (Linuxbrew)
Only used for packages not available in Nixpkgs (e.g. `herdr`):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt-get install build-essential bubblewrap
```
Shell integration (`brew shellenv`) is already configured via `home.nix`, so it works automatically whenever you open a new terminal.

### 5. herdr (via Homebrew, not Nix)
```bash
brew install herdr
```

### 6. GitHub SSH key
```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
Add the output on GitHub under **Settings → SSH and GPG keys → New SSH key**.

Test with:
```bash
ssh -T git@github.com
```

## Getting started (fresh machine)

```bash
git clone git@github.com:moldamolda/molda-dotfiles.git ~/molda_dotfiles
cd ~/molda_dotfiles
chmod +x rebuild.sh
./rebuild.sh "initial setup"
```

## Daily use

Edit `home.nix`, then run:
```bash
./rebuild.sh "short message about the change"
```

This applies the change to the system, commits, and pushes to GitHub in one command.

## Structure

- `flake.nix` - defines inputs (nixpkgs, home-manager) and the entry point
- `home.nix` - the actual configuration: packages, shell, editor
- `rebuild.sh` - applies changes + git commit + push
- `flake.lock` - locked versions (auto-generated, don't edit manually)

## Notes

- `claude-code` requires `nixpkgs.config.allowUnfree = true` (already set in `home.nix`)
- Homebrew installs to `/home/linuxbrew/.linuxbrew` and is separate from Nix - packages from it (`herdr`) are not part of the declarative Nix config and must be reinstalled manually on a new machine
