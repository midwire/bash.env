# Configure the docker machine environment
if which docker-machine > /dev/null; then eval $(docker-machine env default); fi

# Remove all stopped containers
alias dck_prune="docker container prune"
# Run detached with ports exposed
alias dck_detached="docker run -d -P"
