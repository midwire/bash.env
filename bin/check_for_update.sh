#!/bin/sh

_current_epoch() {
  echo $(($(date +%s) / 60 / 60 / 24))
}

_update_env_update() {
  echo "LAST_EPOCH=$(_current_epoch)" > ~/.env-update
}

_upgrade_env() {
  $dot_env_path/bin/upgrade.env
  _update_env_update
}

if [ -f ~/.env-update ]; then
  . ~/.env-update

  if [ -z "$LAST_EPOCH" ]; then
    _update_env_update && return 0;
  fi

  epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
  if [ $epoch_diff -gt 6 ]; then
    if [ "$DISABLE_UPDATE_PROMPT" = "true" ]; then
      _upgrade_env
    else
      echo "[.env] Would you like to check for updates?"
      echo "Type Y to update .env: \c"
      read line
      if [ "$line" = Y ] || [ "$line" = y ]; then
        _upgrade_env
      fi
    fi
  fi
else
  # create the env file
  _update_env_update
fi
