#!/usr/bin/env bash

set -euo pipefail

command_name="${1:-}"

battery() {
  if command -v pmset >/dev/null 2>&1; then
    local line pct state
    line="$(pmset -g batt 2>/dev/null | awk 'NR==2 {print; exit}')"
    pct="$(printf '%s\n' "${line}" | grep -Eo '[0-9]+%' | head -n1 || true)"
    state="$(printf '%s\n' "${line}" | awk -F'; *' 'NR==1 {print $2}' | tr '[:upper:]' '[:lower:]' || true)"

    if [[ -n "${pct}" ]]; then
      printf '%s %s' "${pct}" "${state:-unknown}"
      return
    fi
  fi

  printf 'n/a'
}

sessions() {
  if ! command -v tmux >/dev/null 2>&1; then
    printf 'none'
    return
  fi

  local listing
  listing="$(tmux list-sessions -F '#{session_name}#{?session_attached,*,}' 2>/dev/null || true)"

  if [[ -z "${listing}" ]]; then
    printf 'none'
    return
  fi

  printf '%s\n' "${listing}" | awk 'BEGIN { sep = "" } { printf "%s%s", sep, $0; sep = ", " }'
}

case "${command_name}" in
  battery)
    battery
    ;;
  sessions)
    sessions
    ;;
  *)
    printf 'usage: %s {battery|sessions}\n' "${0##*/}" >&2
    exit 1
    ;;
esac
