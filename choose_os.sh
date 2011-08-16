OS=`uname`
if [[ $OS == 'Darwin' ]]; then
	echo "OS is Darwin"
elif [[ $OS == 'SunOS' ]]; then
	echo "OS is SunOS"
elif [[ $OS == 'Linux' ]]; then
	echo "OS is Linux"
else
	echo "Sorry, no portable environment support for your platform: '$OS'"
	exit 1
fi
OS_DIR=$HOME/.env/$OS

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
