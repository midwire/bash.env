OS=`uname`
if [[ $OS == 'Darwin' ]]; then
	echo "OS is Darwin"
	OS_DIR=$HOME/.env/$OS
elif [[ $OS == 'SunOS' ]]; then
	echo "OS is SunOS"
	OS_DIR=$HOME/.env/sunos
elif [[ $OS == 'Linux' ]]; then
	echo "OS is Linux"
	OS_DIR=$HOME/.env/linux
else
	echo "Sorry, no portable environment support for your platform: '$OS'"
	exit 1
fi

# Make sure globals are sourced before OS specifics
for i in $HOME/.env/global_*.sh ; do
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
unset i
