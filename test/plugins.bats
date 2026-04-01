#!/usr/bin/env bats

load test_helper

@test "plugin directory exists" {
  [[ -d "$dot_env_path/plugins" ]]
}

@test "plugins.sh sources enabled plugins" {
  plugins="path"
  source "$dot_env_path/plugins/plugins.sh"
  # path plugin should have run (it adds to PATH)
  [[ -n "$PATH" ]]
}

@test "all plugin files pass bash syntax check" {
  local failed=0
  for f in "$dot_env_path"/plugins/*/*.plugin.sh; do
    if ! bash -n "$f" 2>/dev/null; then
      echo "Syntax error in: $f" >&2
      failed=1
    fi
  done
  [[ "$failed" -eq 0 ]]
}

@test "extract plugin defines extract function" {
  source "$dot_env_path/plugins/extract/extract.plugin.sh"
  type extract
}

@test "colored_man_pages plugin sets LESS_TERMCAP variables" {
  source "$dot_env_path/plugins/colored_man_pages/colored_man_pages.plugin.sh"
  [[ -n "$LESS_TERMCAP_mb" ]]
  [[ -n "$LESS_TERMCAP_md" ]]
  [[ -n "$LESS_TERMCAP_me" ]]
}

@test "command_duration plugin defines ps1_command_duration function" {
  source "$dot_env_path/plugins/command_duration/command_duration.plugin.sh"
  type ps1_command_duration
}
