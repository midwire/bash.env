# Determine OS
OS=`uname`
if [[ $OS == 'Darwin' ]]; then
	echo "Sourcing Darwin Environment"
elif [[ $OS == 'SunOS' ]]; then
	echo "Sourcing SunOS Environment"
elif [[ $OS == 'Linux' ]]; then
	echo "Sourcing Linux Environment"
else
	echo "Sorry, no portable environment support for your platform: '$OS'"
	exit 1
fi
OS_DIR=$HOME/.env/os/$OS

# Make sure globals are sourced before OS specifics
for i in $HOME/.env/global/global_*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done

# Now source OS specifics
for i in $OS_DIR/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done

# Source Host specifics if there are any for the current host
if [[ ! -z "$HOSTNAME" ]]; then
	HOST_DIR=$HOME/.env/host/$HOSTNAME
	echo "Sourcing '$HOSTNAME' Specific Environment"
	for i in $HOST_DIR/*.sh ; do
	  if [ -r "$i" ]; then
	  	. $i
	  fi
	done
fi

unset i
