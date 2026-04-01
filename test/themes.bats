#!/usr/bin/env bats

load test_helper

@test "themes directory exists" {
  [[ -d "$dot_env_path/themes" ]]
}

@test "all theme files pass bash syntax check" {
  local failed=0
  for f in "$dot_env_path"/themes/*/theme.sh; do
    if ! bash -n "$f" 2>/dev/null; then
      echo "Syntax error in: $f" >&2
      failed=1
    fi
  done
  [[ "$failed" -eq 0 ]]
}

@test "load_theme.sh passes syntax check" {
  bash -n "$dot_env_path/themes/load_theme.sh"
}

@test "default theme exists" {
  [[ -f "$dot_env_path/themes/default/theme.sh" ]]
}

@test "load_theme.sh defines ps1 helper functions" {
  theme="default"
  source "$dot_env_path/themes/load_theme.sh"
  type ps1_git_branch
  type ps1_git_status
  type ps1_ruby
  type ps1_prompt_char
}

@test "NO_COLOR suppresses color definitions" {
  NO_COLOR=1
  theme="default"
  source "$dot_env_path/themes/load_theme.sh"
  [[ -z "$BLACK" ]]
  [[ -z "$RED" ]]
  [[ -z "$GREEN" ]]
  unset NO_COLOR
}
