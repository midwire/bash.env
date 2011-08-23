# .env

Is a comprehensive bash environment system.

Make sure you customize the individual files to your own taste.

## Install

To use it:

Clone the project into your home directory, then add the following to your $HOME/.bashrc file:

    . $HOME/.env/source.sh

You will then want to create a specific set of .env files for your local machine:

    config.env

## Propagating to other hosts ##

If you want to copy .env to another host, simply type:

    propagate_env_to_host [user@]HOSTNAME

... which will compress your local .env, copy it to the specified host and decompress it.

## Make it better

Please feel free to fork it, branch it, change it and send me a pull request.

Cheers,

-- Midwire
