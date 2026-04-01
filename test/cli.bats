#!/usr/bin/env bats

load test_helper

setup() {
  export CONF_FILE="$BATS_TMPDIR/bash.env.conf.$$"
  rm -f "$CONF_FILE"
}

teardown() {
  rm -f "$CONF_FILE"
}

@test "bin/bash.env passes syntax check" {
  bash -n "$dot_env_path/bin/bash.env"
}

@test "bash.env help shows available commands" {
  local output
  output=$("$dot_env_path/bin/bash.env" help 2>&1)
  [[ "$output" == *"help"* ]]
  [[ "$output" == *"search"* ]]
  [[ "$output" == *"doctor"* ]]
  [[ "$output" == *"enable"* ]]
  [[ "$output" == *"disable"* ]]
  [[ "$output" == *"preview"* ]]
  [[ "$output" == *"profile"* ]]
  [[ "$output" == *"reload"* ]]
}
