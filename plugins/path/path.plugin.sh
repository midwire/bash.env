paths="
/bin
/sbin
/usr/local/sbin
/usr/bin
/usr/sbin
/usr/X11/bin"

EGREP=`which egrep`
function pathmunge () {
  echo "PARAM: $1"
  # If it exists then remove it so we can shuffle it to the end or beginning of the PATH
  if echo $PATH | $EGREP "(^|:)$1($|:)" > /dev/null ; then
    safe_param=$(printf "%s\n" "$1" | sed 's/[][\.*^$(){}?+|/]/\\&/g')
    PATH=`echo $PATH | sed -Ee "s/(^|:)$safe_param($|:)/:/"`
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
  export PATH=`echo $PATH | sed -e 's/^://' -e 's/::/:/g'`
}

for p in $paths; do
  pathmunge $p
done

unset paths
