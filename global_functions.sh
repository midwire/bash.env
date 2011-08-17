function add_ssh_key_to_host {
	cat ~/.ssh/id_dsa.pub | ssh $1 "cat >> .ssh/authorized_keys"
}
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
	echo '[[ -r $HOME/.env/choose_os.sh ]] && . $HOME/.env/choose_os.sh'
	cd $PWD
}
