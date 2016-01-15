paths="
/bin
/sbin
/usr/local/sbin
/usr/bin
/usr/sbin
/usr/X11/bin
$dot_env_path/bin"

alias egrep=`which egrep`
unalias egrep 2>&1 > /dev/null
EGREP=`which egrep`
alias sed=`which sed`
unalias sed 2>&1 > /dev/null
SED=`which sed`

# pathmunge function
# Adds, or modifies, a path in your Bash session
# @param1 - The path to add
# @param2 - [before|after] Where to add the path, before or after the current PATH
#           string. Defaults to after.
# @param3 - [true|false] Force add the path even if it doesn't exist on disk currently.
#           Defaults to false, meaning the new path will not be added unless it exists.
#           If this parameter exists it means true, otherwise it is false.
#
# Examples:
#  pathmunge "$HOME/local/bin" after
#  pathmunge ./maynotexist before force
function pathmunge () {
  # If it exists then remove it so we can shuffle it to the end or beginning of the PATH
  if echo $PATH | $EGREP "(^|:)$1($|:)" > /dev/null ; then
    safe_param=$(printf "%s\n" "$1" | $SED 's/[][\.*^$(){}?+|/]/\\&/g')
    PATH=`echo $PATH | $SED -e "s/:$safe_param:/:/"`
    PATH=`echo $PATH | $SED -e "s/^$safe_param://"`
    PATH=`echo $PATH | $SED -e "s/:$safe_param$//"`
  fi

  # add the path in the apropriate location,
  # but only if the path exists on disk, unless we are forcing it ($3)
  local addit=0
  if [[ -d "$1" ]]; then
    addit=1
  else
    # $1 does not exist, so check if we are forcing it
    if [[ ! -z "$3" ]]; then
      addit=1
    fi
  fi

  if [[ $addit -eq 1 ]]; then
    if [ "$2" = "before" ] ; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi
  fi

  # Remove : at the beginning and duplicate :: colons
  export PATH=`echo $PATH | $SED -e 's/^://' -e 's/::/:/g'`
}

# Solaris doesn't like 'sed -E'
if [ "$OS" != "SunOS" ]; then
  for p in $paths; do
    pathmunge $p
  done
fi

unset paths
