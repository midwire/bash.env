[[ -z "$PS1" ]] && return
export DOT_ENV_PATH="$HOME/.env"
export DOT_ENV_HOME_HOST='spark.local'

if [[ "$SHLVL" == "1" ]]; then
	DOT_ENV_VERSION=`cat $DOT_ENV_PATH/VERSION`
	echo ".env v$DOT_ENV_VERSION - http://github.com/midwire/.env"
fi

# Determine OS
OS=`uname`
if [[ $OS == 'Darwin' ]]; then
	x=1
elif [[ $OS == 'SunOS' ]]; then
	x=1
elif [[ $OS == 'Linux' ]]; then
	x=1
else
	echo "Sorry, no portable environment support for your platform: '$OS'"
	exit 1
fi
OS_DIR=$DOT_ENV_PATH/os/$OS

# Make sure globals are sourced before OS specifics
if [[ "$SHLVL" == "1" ]]; then
	echo "Sourcing Global Environment"
fi
for i in $DOT_ENV_PATH/global/global_*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done

# Now source OS specifics
if [[ "$SHLVL" == "1" ]]; then
	echo "Sourcing $OS Environment"
fi
for i in $OS_DIR/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done

# Source Host specifics if there are any for the current host
if [[ ! -z "$HOSTNAME" ]]; then
	HOST_DIR=$DOT_ENV_PATH/host/`hostname`
	if [[ "$SHLVL" == "1" ]]; then
		echo "Sourcing '$HOSTNAME' Environment"
	fi
	for i in $HOST_DIR/*.sh ; do
	  if [ -r "$i" ]; then
	  	. $i
	  fi
	done
fi

unset i
