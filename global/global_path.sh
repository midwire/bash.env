# Add some useful directories to our PATH if necessary. Add all the paths
# you want to the $paths variable

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
# TODO: find a solution to remove duplicate path entries on Solaris
if [[ $OS != 'SunOS' ]]; then
	PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`
fi
PATH=`echo $PATH | sed -e 's/^\://' -e 's/\:\:/:/g'`

unset paths
export PATH
