# This plugin removes the "grep" command from the output grepping through 'ps'
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# I type this way too often to not make it a plugin
# Tested on MacOs, Linux and Solaris
function psgrep {
  ps aux|grep $@|grep -v grep
}
