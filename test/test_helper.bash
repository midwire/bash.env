#!/bin/bash
# Common test setup for bash.env bats tests

export DOT_ENV_TEST=1
export dot_env_path="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export dot_env_custom="$dot_env_path/custom"
export HOSTNAME="testhost"

# Source colors and functions for tests
source "$dot_env_path/global/global_colors.sh"
source "$dot_env_path/global/global_functions.sh"
