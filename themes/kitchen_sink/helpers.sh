#!/bin/bash
# Helper functions for kitchen_sink theme
# Sourced by local.sh and remote.sh

__ks_ps1_node() {
  local node_ver
  node_ver=$(command -v node >/dev/null 2>&1 && node --version 2>/dev/null)
  if [[ -n "$node_ver" ]]; then
    printf "%s" "$node_ver"
  fi
}

__ks_ps1_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    printf "%s" "$(basename "$VIRTUAL_ENV")"
  fi
}

__ks_ps1_exit_code() {
  if [[ "$__ks_last_exit" -ne 0 ]]; then
    printf "%s" "$__ks_last_exit"
  fi
}

__ks_ps1_jobs() {
  local running stopped total
  running=$(jobs -rp 2>/dev/null | wc -l)
  stopped=$(jobs -sp 2>/dev/null | wc -l)
  total=$(( running + stopped ))
  if [[ "$total" -gt 0 ]]; then
    printf "%s" "$total"
  fi
}
