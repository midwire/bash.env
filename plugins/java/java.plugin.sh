paths="
.
"

EGREP=`which egrep`
function classpath_munge () {
  # If it exists then remove it so we can shuffle it to the end or beginning of the CLASSPATH
  if echo $CLASSPATH | $EGREP "(^|:)$1($|:)" > /dev/null ; then
    safe_param=$(printf "%s\n" "$1" | sed 's/[][\.*^$(){}?+|/]/\\&/g')
    CLASSPATH=`echo $CLASSPATH | sed -Ee "s/(^|:)$safe_param($|:)/:/"`
  fi
  # add the path in the apropriate location
  if [ -r "$1" ]; then
    if [ "$2" = "before" ] ; then
      CLASSPATH="$1:$CLASSPATH"
    else
      CLASSPATH="$CLASSPATH:$1"
    fi
  fi
  # Remove : at the beginning and duplicate ::
  export CLASSPATH=`echo $CLASSPATH | sed -e 's/^://' -e 's/::/:/g'`
}

for p in $paths; do
  classpath_munge $p
done

unset paths
