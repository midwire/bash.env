# Add your public SSH key to a remote host
function add_ssh_key_to_host {
	if [[ $# -lt 1 ]]; then
		echo_warn "Usage: add_ssh_key_to_host [user@]HOSTNAME"
		return
	fi
	cat ~/.ssh/id_dsa.pub | ssh $1 "cat >> .ssh/authorized_keys"
}

# Propagate your entire environment system to a remote host
function propagate_env_to_host {
	if [[ $# -lt 1 ]]; then
		echo_warn "Usage: propagate_env_to_host [user@]HOSTNAME"
		return
	fi
	host=$1
	shift 1
	ENVFILE=$HOME/env.tar.gz
	PWD=`pwd`
	cd $HOME
	echo_info "Compressing local environment..."
	tar cfvz $ENVFILE .env/ &> /dev/null
	echo_info "Copying environment to $host..."
	scp $ENVFILE $host:
	echo_info "Installing environment on $host..."
	ssh $host "rm -rf $HOME/.env/ && gunzip < env.tar.gz |tar xfv -" &> /dev/null
	echo_warn "Don't forget to add this your .bashrc file:"
	echo_warn 'if [[ -n "$PS1" ]]; then'
	echo_warn '  [[ -r $HOME/.env/source.sh ]] && . $HOME/.env/source.sh'
	echo_warn 'fi'
	cd $PWD
}

# Configure environment settings for your local machine.
function config.env {
	DIR="$DOT_ENV_PATH/host/$HOSTNAME"
	mkdir -p "$DIR"
	touch "$DIR/alias.sh"
	touch "$DIR/env.sh"
	touch "$DIR/functions.sh"
	cd "$DIR"
	echo_info "Edit these files to customize your local environment."
	ls -1AtF
}
