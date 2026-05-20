# Environment shared by every zsh invocation.

if [[ -d "$HOME/.foundry/bin" ]]; then
  export PATH="$PATH:$HOME/.foundry/bin"
fi

if [[ -r "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
