# Add some useful directories to our PATH if necessary. Add all the paths
# you want to the $paths variable

# This currently resets your path to zero and adds from there.  Be sure to add ALL of the paths
# you want in your environment, either here or in more specific path.sh files

paths="${DOT_ENV_PATH}/bin"
paths="${paths} ${HOME}/bin"
paths="${paths} /sbin"
paths="${paths} /bin"
paths="${paths} /usr/X11/bin"
paths="${paths} /usr/local/bin"
paths="${paths} /usr/sbin"
paths="${paths} /usr/bin"

EGREP=`which egrep`
function pathmunge () {
	if ! echo $PATH | $EGREP "(^|:)$1($|:)" > /dev/null ; then
		if [ "$2" = "before" ] ; then
			PATH=$1:$PATH
		else
			PATH=$PATH:$1
		fi
	fi
}

for p in $paths; do
	pathmunge $p
done

# Remove Duplicates
if [[ $OS != 'SunOS' ]]; then
	PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`
fi
PATH=`echo $PATH | sed -e 's/^\://' -e 's/\:\:/:/g'`

unset paths
export PATH
