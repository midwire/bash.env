# Add some useful directories to our PATH if necessary. Add all the paths
# you want to the $paths variable

PATH=' '
paths="${HOME}/bin"
paths="${paths} /sbin"
paths="${paths} /bin"
paths="${paths} /usr/X11/bin"
paths="${paths} /usr/local/bin"
paths="${paths} /usr/sbin"
paths="${paths} /usr/bin"

function pathmunge () {
	if ! echo $PATH | /usr/bin/egrep -q "(^|:)$1($|:)" ; then
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
# PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`
PATH=`echo $PATH | sed -e 's/^\://' -e 's/\:\:/:/g'`

unset paths
export PATH
