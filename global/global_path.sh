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

PATH=`echo $PATH | sed -e 's/^\://' -e 's/\:\:/:/g'`
unset paths
export PATH
