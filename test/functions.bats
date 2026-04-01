#!/usr/bin/env bats

load test_helper

@test "global_functions.sh passes syntax check" {
  bash -n "$dot_env_path/global/global_functions.sh"
}

@test "global_colors.sh passes syntax check" {
  bash -n "$dot_env_path/global/global_colors.sh"
}

@test "ask function is defined" {
  type ask
}

@test "dot_env_log function is defined" {
  type dot_env_log
}

@test "dot_env_log respects log level threshold" {
  dot_env_log_level="error"
  # info message should produce no output when threshold is error
  local output
  output=$(dot_env_log info "test message" 2>&1)
  [[ -z "$output" ]]
}

@test "dot_env_log shows error when threshold allows" {
  dot_env_log_level="error"
  local output
  output=$(dot_env_log error "test error" 2>&1)
  [[ "$output" == *"test error"* ]]
}

@test "echo_info produces output" {
  local output
  output=$(echo_info "hello" 2>&1)
  [[ "$output" == *"hello"* ]]
}

@test "echo_warn produces output" {
  local output
  output=$(echo_warn "warning" 2>&1)
  [[ "$output" == *"warning"* ]]
}

@test "echo_error produces output" {
  local output
  output=$(echo_error "error" 2>&1)
  [[ "$output" == *"error"* ]]
}
