# SSH agent management

# Check if ssh-agent is already running via socket
if [[ -z "$SSH_AUTH_SOCK" ]] || [[ ! -S "$SSH_AUTH_SOCK" ]]; then
  # Try to find existing agent
  if [[ -r ~/.ssh-agent-env ]]; then
    . ~/.ssh-agent-env >/dev/null
  fi

  # If still no valid agent, start one
  if [[ -z "$SSH_AUTH_SOCK" ]] || [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" >/dev/null
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/.ssh-agent-env
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> ~/.ssh-agent-env
  fi
fi

# Function to add all keys (call manually: ssh_add_keys)
ssh_add_keys() {
  local keys
  keys=$(find ~/.ssh -maxdepth 1 -name 'id_*' ! -name '*.pub' 2>/dev/null)
  for k in $keys; do
    ssh-add "$k"
  done
}
