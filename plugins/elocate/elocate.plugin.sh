# This plugin is useful when on a remote box and the admin has neglected
# to install locate or slocate
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias eupdatedb="$THISDIR/update_locate_db.sh"
alias elocate="$THISDIR/elocate.sh"
