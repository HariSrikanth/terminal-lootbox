# terminal-lootbox

Portable terminal config for a new Mac: zsh, Powerlevel10k, tmux, Neovim, and Git defaults.

## Quickstart

```sh
git clone git@github.com:HariSrikanth/terminal-lootbox.git ~/terminal-lootbox
cd ~/terminal-lootbox
./install.sh --brew
nvim --headless +PackerSync +qa
```

Use `./install.sh --dry-run` first if the machine already has local config you care about. Existing files are moved to `~/.terminal-lootbox-backup/<timestamp>/` before this repo is linked in. The installer also clones Oh My Zsh, Powerlevel10k, zsh-autosuggestions, and packer.nvim when they are missing.

## What Gets Installed

- `home/.zshrc`: Oh My Zsh with `powerlevel10k/powerlevel10k`, `git`, and `zsh-autosuggestions`.
- `home/.p10k.zsh`: current Powerlevel10k prompt layout.
- `home/.tmux.conf` and `home/.tmux/status.sh`: mouse-enabled tmux with a compact top status bar.
- `config/nvim`: Neovim config using packer, Sonokai, Telescope, Treesitter, Gitsigns, and nvim-tree.
- `home/.gitconfig`: Git identity, main as default branch, and GitHub CLI credential helper.
- `Brewfile`: common packages needed by the config.

## External Tools

The shell config detects optional tools before loading them. Install these separately when you want the matching prompt segments or completions:

- Google Cloud SDK at `~/google-cloud-sdk`
- Docker Desktop completions at `~/.docker/completions`
- Conda at `/opt/homebrew/anaconda3`
- Foundry at `~/.foundry/bin`
- Rust/Cargo at `~/.cargo/env`
- rbenv on `PATH`

## Notes For Codex

On another machine, ask Codex to clone this repo and run:

```sh
./install.sh --dry-run
./install.sh --brew
nvim --headless +PackerSync +qa
```

The repo intentionally excludes generated Neovim packer output and local assistant state.
