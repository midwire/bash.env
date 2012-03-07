[[ -z "$PS1" ]] && return
dot_env_path="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
	DOT_ENV_VERSION=`cat $dot_env_path/VERSION`
	echo ".env v$DOT_ENV_VERSION - http://github.com/midwire/.env"
fi

# Determine OS
OS=`uname`
if [[ "$OS" != "Darwin" && "$OS" != "Linux" && "$OS" != "SunOS" ]]; then
	echo "Sorry, dot-env does not support your platform: '$OS'"
	return 1
fi
OS_DIR=$dot_env_path/os/$OS

# Make sure globals are sourced before OS specifics
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
	echo "Sourcing Global Environment"
fi
. $dot_env_path/global/global.sh

# Now source OS specifics
if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
	echo "Sourcing $OS Environment"
fi
for i in $OS_DIR/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done

# Source Host specifics if there are any for the current host
if [[ ! -z "$HOSTNAME" ]]; then
	HOST_DIR=$dot_env_path/host/`hostname`
	if [[ "$SHLVL" == "1" && "$dot_env_verbose" == "1" ]]; then
		echo "Sourcing '$HOSTNAME' Environment"
	fi
	for i in $HOST_DIR/*.sh ; do
	  if [ -r "$i" ]; then
	  	. $i
	  fi
	done
fi

unset i
