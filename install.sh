#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
backup_dir="$HOME/.terminal-lootbox-backup/$(date +%Y%m%d-%H%M%S)"
dry_run=0
copy_mode=0
install_brew=0

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--dry-run] [--copy] [--brew]

Links this repo's terminal config into your home directory.

Options:
  --dry-run  Print planned changes without writing anything.
  --copy     Copy files instead of creating symlinks.
  --brew     Run brew bundle before linking config.
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=1 ;;
    --copy) copy_mode=1 ;;
    --brew) install_brew=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
  esac
done

run() {
  if [[ "$dry_run" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

ensure_git_repo() {
  local url="$1"
  local target="$2"

  if [[ -d "$target/.git" ]]; then
    echo "Already installed: $target"
    return
  fi

  if [[ -e "$target" ]]; then
    echo "Skipping $target because it exists but is not a git checkout." >&2
    return
  fi

  run mkdir -p "$(dirname "$target")"
  run git clone --depth 1 "$url" "$target"
}

backup_existing() {
  local target="$1"

  if [[ -L "$target" || -e "$target" ]]; then
    local rel="${target#$HOME/}"
    run mkdir -p "$backup_dir/$(dirname "$rel")"
    run mv "$target" "$backup_dir/$rel"
    echo "Backed up $target -> $backup_dir/$rel"
  fi
}

install_path() {
  local source="$1"
  local target="$2"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "Already linked: $target"
    return
  fi

  backup_existing "$target"
  run mkdir -p "$(dirname "$target")"

  if [[ "$copy_mode" -eq 1 ]]; then
    if [[ -d "$source" ]]; then
      run cp -R "$source" "$target"
    else
      run cp "$source" "$target"
    fi
    echo "Copied $target"
  else
    run ln -s "$source" "$target"
    echo "Linked $target"
  fi
}

if [[ "$install_brew" -eq 1 ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed. Install it from https://brew.sh, then rerun ./install.sh --brew." >&2
    exit 1
  fi
  run brew bundle --file "$repo_dir/Brewfile"
fi

ensure_git_repo https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
ensure_git_repo https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
ensure_git_repo https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

install_path "$repo_dir/home/.zshrc" "$HOME/.zshrc"
install_path "$repo_dir/home/.zprofile" "$HOME/.zprofile"
install_path "$repo_dir/home/.zshenv" "$HOME/.zshenv"
install_path "$repo_dir/home/.p10k.zsh" "$HOME/.p10k.zsh"
install_path "$repo_dir/home/.tmux.conf" "$HOME/.tmux.conf"
install_path "$repo_dir/home/.tmux" "$HOME/.tmux"
install_path "$repo_dir/home/.gitconfig" "$HOME/.gitconfig"
install_path "$repo_dir/config/nvim" "$HOME/.config/nvim"

packer_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/packer.nvim"
ensure_git_repo https://github.com/wbthomason/packer.nvim "$packer_dir"

echo
echo "Done. Open a new terminal, then run:"
echo "  nvim --headless +PackerSync +qa"
echo "  tmux source-file ~/.tmux.conf"
