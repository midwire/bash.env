# Make sure you have your ssh key in the remote ~/.ssh/authorized_keys file
function propagate_environment_to_fidelity_servers {
	servers="amd-203 amd-230 amd-215 amd-241 pr-ra-1 pr-ra-2 pr-ra-3 pr-ra-4 ub40"
	for s in $servers; do
		echo $s
		cat ~/.env/fidelity/.blackburn-environment | ssh $s "cat > .blackburn-environment"
	done
}
