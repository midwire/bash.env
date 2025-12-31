# Docker Machine (deprecated but kept for legacy support)
if command -v docker-machine &>/dev/null; then
  # Only configure if a default machine exists and is running
  if docker-machine status default &>/dev/null; then
    eval "$(docker-machine env default 2>/dev/null)"
  fi
fi

# Container management
alias dck_prune="docker container prune"
alias dck_detached="docker run -d -P"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dimg="docker images"
alias dlog="docker logs"
alias dexec="docker exec -it"

# Cleanup
alias dck_prune_all="docker system prune -a"
alias dck_prune_volumes="docker volume prune"
