# .env

Is a comprehensive bash environment system, under heavy development.  It is not recommended for those just beginning to use the Bash shell.  However, veteran Bash users may find it useful.

Make sure you customize the individual files to your own taste.

## Install

To use it:

Clone the project into your home directory, then add the following to your $HOME/.bashrc file:

    if [[ -n "$PS1" ]]; then
      [[ -r $HOME/.env/source.sh ]] && . $HOME/.env/source.sh
    fi

You will then want to create a specific set of .env files for your local machine:

    configthis.env

## Add your SSH key to another host ##

    add_ssh_key_to_host [user@]HOSTNAME

... which will append your public `~/.ssh/id_dsa.pub` key to the host's authorized_keys file and allow you to login without a password.

## Propagating to other hosts ##

If you want to copy .env to another host, simply type:

    propagate_env_to_host [user@]HOSTNAME

... which will compress your local .env, copy it to the specified host and decompress it.

## Make it better

Please feel free to fork it, branch it, change it and send me a pull request.

Cheers,

-- Midwire
