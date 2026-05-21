# terminal-lootbox

Portable terminal config for a new Mac: zsh, Powerlevel10k, tmux, and Neovim.

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
- `Brewfile`: common packages needed by the config.

## Notes For Codex

On another machine, ask Codex to clone this repo and run:

```sh
./install.sh --dry-run
./install.sh --brew
nvim --headless +PackerSync +qa
```

The repo intentionally excludes generated Neovim packer output and local assistant state.
