# Based on the ZSH plugin: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/brew/brew.plugin.zsh
# Updated for modern Homebrew (cask commands integrated into brew)

# NOTE: This is for macOS only

alias brewp='brew pin'
alias brews='brew list -1'
alias brewsp='brew list --pinned'
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'

# Cask aliases (modern syntax - 'brew cask' deprecated since Homebrew 2.6.0)
alias brewc='brew list --cask'
alias brewco='brew outdated --cask'
alias brewcu='brew upgrade --cask'

# Cleanup old versions
alias brewclean='brew cleanup --prune=all'

# Show what would be removed
alias brewclean_dry='brew cleanup --dry-run'
