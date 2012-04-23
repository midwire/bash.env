paths="
/bin
/sbin
/usr/local/sbin
/usr/bin
/usr/sbin
/usr/X11/bin
$dot_env_path/bin"

EGREP=`which egrep`
SED=`which sed`

function pathmunge () {
  # If it exists then remove it so we can shuffle it to the end or beginning of the PATH
  if echo $PATH | $EGREP "(^|:)$1($|:)" > /dev/null ; then
    safe_param=$(printf "%s\n" "$1" | $SED 's/[][\.*^$(){}?+|/]/\\&/g')
    PATH=`echo $PATH | $SED -e "s/:$safe_param:/:/"`
    PATH=`echo $PATH | $SED -e "s/^$safe_param://"`
    PATH=`echo $PATH | $SED -e "s/:$safe_param$//"`
  fi
  # add the path in the apropriate location
  if [ -d "$1" ]; then
    if [ "$2" = "before" ] ; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi
  fi
  # Remove : at the beginning and duplicate ::
  export PATH=`echo $PATH | $SED -e 's/^://' -e 's/::/:/g'`
}

for p in $paths; do
  pathmunge $p
done

unset paths
