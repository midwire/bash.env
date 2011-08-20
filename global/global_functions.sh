# Add your public SSH key to a remote host
function add_ssh_key_to_host {
	if [[ $# -lt 1 ]]; then
		echo "Usage: add_ssh_key_to_host [user@]HOSTNAME"
		return
	fi
	cat ~/.ssh/id_dsa.pub | ssh $1 "cat >> .ssh/authorized_keys"
}

# Propagate your entire environment system to a remote host
function propagate_env_to_host {
	if [[ $# -lt 1 ]]; then
		echo "Usage: propagate_env_to_host [user@]HOSTNAME"
		return
	fi
	host=$1
	shift 1
	ENVFILE=$HOME/env.tar.gz
	PWD=`pwd`
	cd $HOME
	echo "Compressing local environment..."
	tar cfvz $ENVFILE .env/ &> /dev/null
	echo "Copying environment to $host..."
	scp $ENVFILE $host:
	echo "Installing environment on $host..."
	ssh $host "gunzip < env.tar.gz |tar xfv -" &> /dev/null
	echo "Don't forget to add this line to your .bashrc file:"
	echo '[[ -r $HOME/.env/source.sh ]] && . $HOME/.env/source.sh'
	cd $PWD
}

# Configure environment settings for your local machine.
function config.env {
	DIR="$HOME/.env/hosts/$HOSTNAME"
	mkdir -p "$DIR"
	touch "$DIR/alias.sh"
	touch "$DIR/env.sh"
	touch "$DIR/functions.sh"
	cd "$DIR"
	echo ">>> Edit these files to customize your local environment."
	ls -1AtF
}
