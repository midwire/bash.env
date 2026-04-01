# Command Duration plugin
# Tracks and displays execution time for long-running commands.
#
# Set COMMAND_DURATION_THRESHOLD in your .bashrc before sourcing bash.env
# to control the minimum duration (in seconds) before display. Default: 5
#
# Use ps1_command_duration in your theme's PS1 to show the duration.

COMMAND_DURATION_THRESHOLD="${COMMAND_DURATION_THRESHOLD:-5}"
COMMAND_DURATION_DISPLAY=""

_command_duration_start() {
  # Only record the start time if we haven't already (avoids resetting
  # on each DEBUG trap invocation within a single pipeline)
  _command_duration_start_time="${_command_duration_start_time:-$SECONDS}"
}

_command_duration_stop() {
  local elapsed

  if [[ -n "$_command_duration_start_time" ]]; then
    elapsed=$(( SECONDS - _command_duration_start_time ))
    unset _command_duration_start_time

    if [[ "$elapsed" -ge "$COMMAND_DURATION_THRESHOLD" ]]; then
      COMMAND_DURATION_DISPLAY="$(_command_duration_format "$elapsed")"
    else
      COMMAND_DURATION_DISPLAY=""
    fi
  else
    COMMAND_DURATION_DISPLAY=""
  fi
}

_command_duration_format() {
  local total_seconds="$1"
  local hours minutes seconds

  hours=$(( total_seconds / 3600 ))
  minutes=$(( (total_seconds % 3600) / 60 ))
  seconds=$(( total_seconds % 60 ))

  if [[ "$hours" -gt 0 ]]; then
    printf "%dh %dm" "$hours" "$minutes"
  elif [[ "$minutes" -gt 0 ]]; then
    printf "%dm %ds" "$minutes" "$seconds"
  else
    printf "%ds" "$seconds"
  fi
}

ps1_command_duration() {
  if [[ -n "$COMMAND_DURATION_DISPLAY" ]]; then
    printf "%s" "$COMMAND_DURATION_DISPLAY"
  fi
}

# Wire up the DEBUG trap and PROMPT_COMMAND

trap '_command_duration_start' DEBUG

if [[ -z "$PROMPT_COMMAND" ]]; then
  PROMPT_COMMAND="_command_duration_stop"
elif [[ "$PROMPT_COMMAND" != *"_command_duration_stop"* ]]; then
  PROMPT_COMMAND="_command_duration_stop;${PROMPT_COMMAND}"
fi
