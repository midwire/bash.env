# Add some useful directories to our PATH if necessary. Add all the paths
# you want to the $paths variable

PATH=' '
paths="${HOME}/bin"
paths="${paths} /sbin"
paths="${paths} /bin"
paths="${paths} /usr/X11/bin"
paths="${paths} /usr/local/sbin"
paths="${paths} /usr/local/mysql/bin"
paths="${paths} /usr/local/bin"
paths="${paths} /usr/sbin"
paths="${paths} /usr/bin"
paths="${paths} /Developer/usr/bin"

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

# for i in $paths; do
#   if `echo $PATH | egrep $i'(\:|$)' >/dev/null 2>&1`; then
#     continue
#   fi
#   if [ -d $i ]; then
#     PATH=$PATH:$i
#   fi
# done

PATH=`echo $PATH | sed -e 's/^\://' -e 's/\:\:/:/g'`
# Remove Duplicates
# PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`

unset paths
export PATH
