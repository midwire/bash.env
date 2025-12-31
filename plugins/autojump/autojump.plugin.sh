THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find autojump script
_autojump_script=""
if command -v brew &>/dev/null; then
  _brew_prefix="$(brew --prefix)"
  if [[ -s "$_brew_prefix/etc/autojump.sh" ]]; then
    _autojump_script="$_brew_prefix/etc/autojump.sh"
  fi
  unset _brew_prefix
elif [[ -s /usr/share/autojump/autojump.sh ]]; then
  # Linux (Debian/Ubuntu)
  _autojump_script="/usr/share/autojump/autojump.sh"
elif [[ -s /etc/profile.d/autojump.sh ]]; then
  # Linux (Fedora/RHEL)
  _autojump_script="/etc/profile.d/autojump.sh"
fi

if [[ -n "$_autojump_script" ]]; then
  . "$_autojump_script"

  alias jp='j $(pwd)'
  alias jl='j --stat'
  alias je='${EDITOR:-vim} $HOME/.local/share/autojump/autojump.txt'
fi
unset _autojump_script
