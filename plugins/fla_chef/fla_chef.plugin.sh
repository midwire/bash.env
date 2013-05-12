THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the plugin's environment
source "$THISDIR/env.sh"

# ... and aliases
source "$THISDIR/alias.sh"

# Prepend the path
# pathmunge $HOME/development/apps/support/chef/chef_local_tools/.bundle/bin before
