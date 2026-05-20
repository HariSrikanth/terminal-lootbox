# Login shell setup.

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -d "/opt/local/bin" ]]; then
  export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi
