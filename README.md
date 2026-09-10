# dotfiles-wsl2

A WSL2 / Linux port of kunchenguid's [nix-darwin + Home Manager dotfiles](https://github.com/kunchenguid/dotfiles) (from [this video](https://youtu.be/5N-okeDdIuI)).

If you watched the video, loved the setup, and use **WSL2** instead of a Mac - this is for you. Everything that's cross-platform (Nix, Home Manager, packages, shell, editor) works the same way. Everything that was macOS-only (nix-darwin, system defaults, declarative Homebrew) has been replaced or dropped, and this README explains exactly what changed and why.

## What you get

Running `./rebuild.sh` sets up/updates:

- CLI tools via Nix: `ripgrep`, `fd`, `fzf`, `jq`, `lazygit`, `neovim`, `claude-code`
- Shell: `zsh` with Homebrew shell integration
- Editor: `nvim` as the default `$EDITOR`
- Terminal: WezTerm with custom colors and Windows clipboard integration
- Agent workspace manager: herdr (manage Claude/Codex/opencode sessions across workspaces and panes; also works as a general terminal multiplexer)

Everything is declaratively configured - change `home.nix`, run `rebuild.sh`, and you're done.

## Under the hood

If you dig into the config, you'll find:

- **Neovim**: Lazy plugin manager with Rose Pine theme, git integration (Neogit, Gitsigns), file browser (Oil), and more
- **Zsh**: Starship prompt showing git status, auto-completion, syntax highlighting, custom aliases
- **WezTerm**: Tokyo Night theme, 90% opacity, Windows clipboard integration
- **herdr**: AI-agent session manager (Claude, Codex, opencode) with an agents panel, Vim-style keybindings, workspaces and panes

But you don't need to understand any of this to use the setup — it just works out of the box.

## How this differs from the macOS original

| macOS original | WSL2 version |
|---|---|
| `nix-darwin` + `configuration.nix` (system settings, Dock, Finder, menu bar) | Doesn't exist - there's no equivalent OS-level layer on Linux. Home Manager only manages the user level. |
| `nix-homebrew` (installs Homebrew itself, declaratively, as part of the build) | Not available on Linux. Homebrew (Linuxbrew) must be installed manually, once, as a prerequisite. |
| `homebrew.onActivation.cleanup = "zap"` (fully reproducible, self-cleaning Homebrew state) | No equivalent on Linux. Anything installed via `brew` here sits outside the reproducible Nix build and must be reinstalled by hand on a new machine. |
| `darwin-rebuild switch` | `nix run home-manager -- switch` (wrapped in `rebuild.sh`) |

If you're following the video step by step, this table is the map between "what he does" and "what you do instead" at each stage.

## Prerequisites (manual, one-time setup on a fresh machine)

A few things aren't managed by Nix/Home Manager and need to be in place before `./bootstrap.sh` and `./rebuild.sh` will work.

### 1. WSL2 + Ubuntu
Install/update WSL2 with a Linux distro (Ubuntu recommended) from Windows first. Make sure you're on WSL2, not WSL1 (`wsl -l -v` from PowerShell to check).

### 2. GitHub SSH key
Needed to clone this repo over SSH:
```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
Add the output on GitHub under **Settings → SSH and GPG keys → New SSH key**, then test:
```bash
ssh -T git@github.com
```

### 3. win32yank (Windows clipboard integration)
WezTerm and Neovim share the Windows clipboard via `win32yank.exe`, which must be available on your Windows `PATH` (it ships with the Neovim Windows install, or install it standalone). Without it, copy/paste between WSL and Windows won't work. This lives on the Windows side, so it isn't installed by `bootstrap.sh`.

## Getting started (fresh machine)

After the prerequisites above, clone the repo and run the bootstrap script:

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles-wsl2.git ~/dotfiles-wsl2
cd ~/dotfiles-wsl2
./bootstrap.sh
```

`bootstrap.sh` installs the system dependencies (`build-essential`, `bubblewrap`, `unzip`, WSLg graphics libs), WezTerm, [Nix](https://install.determinate.systems/nix) (Determinate Systems installer), and Homebrew (Linuxbrew). It's idempotent - already-installed tools are skipped.

Then restart your shell so Nix and Homebrew are on your `PATH`, install `herdr` (only available via Homebrew, not Nixpkgs), and run the first build:

```bash
exec zsh
brew install herdr
./rebuild.sh "initial setup"
```

Homebrew shell integration (`brew shellenv`) is wired up via `home.nix`, so it works automatically in every new terminal after your first `rebuild.sh` run.

## Daily use

Edit `home.nix`, then:
```bash
./rebuild.sh "short message about the change"
```
This applies the change, commits, and pushes - all in one command.

## Make it yours

- **Username**: change `home.username` and `home.homeDirectory` in `home.nix`, and the config name (`.#YOUR_USERNAME`) in `flake.nix` and `rebuild.sh` to match your own Linux username.
- **Packages**: add/remove from `home.packages` in `home.nix`.
- **herdr / Homebrew packages**: not managed by Nix here - install via `brew install <package>` and note it in this README so it's not forgotten on a fresh machine.

## Repo structure

- `flake.nix` - defines inputs (nixpkgs, home-manager) and the entry point
- `home.nix` - the actual configuration: packages, shell, editor
- `bootstrap.sh` - installs system-level dependencies (apt packages, WezTerm, Nix, Homebrew) on a fresh machine
- `rebuild.sh` - applies changes + git commit + push
- `flake.lock` - locked versions (auto-generated, don't edit manually)

## Contributing

These are personal dotfiles, shared publicly so people can read, learn from, and fork them freely. PRs and feature requests aren't accepted; found a bug? Open an Issue. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Credit

Based on kunchenguid's original macOS dotfiles: [https://github.com/kunchenguid/dotfiles], demonstrated in [this video](https://youtu.be/5N-okeDdIuI). This repo exists purely to make the same ideas work for WSL2/Linux users who don't have a Mac.
