THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function treecmd {
  if [[ -x $(which tree) ]]; then
    tree $1
  else
    find $1
  fi
}

function ansible-role-init {
  if [[ ! -z $1 ]]; then
    echo "Ansible Role: $1 Creating..."
    ansible-galaxy init $1
    treecmd $1
  else
    echo "Usage: ansible-role-init ROLE_NAME"
  fi
}

# Ansible-related aliases
alias acfg='ansible-config'
alias acon='ansible-console'
alias adoc='ansible-doc'
alias agal='ansible-galaxy'
alias ainv='ansible-inventory'
alias ans='ansible'
alias ap='ansible-playbook'
alias aplaybook='ansible-playbook'
alias apull='ansible-pull'
alias arinit='ansible-role-init'
alias av='ansible-vault'
alias aver='ansible --version'

# List the defined ansible aliases
alias ansible_aliases='alias|grep ansible'
