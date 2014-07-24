# .env

**Version: 0.4.1**

**Bash.env** is a cascading Bash environment system.  It provides Bash shell-prompt themes, handy functions, aliases, and tools for the Bash power user.

Not all development environments are the same. **Bash.env** is handy in that you can customize your specific environment at 3 levels. Globals load first, then operating system customizations and lastly specifics for the particular host you are working on.

I work on many different machines remotely using SSH. Though I love Z-shell, it does not come standard on most operating systems and usually has to be installed manually.  This can be problematic on any environment where you don't have system rights to install new software.  After using Z-shell for a few months I decided to go back to Bash because it comes standard on all operating systems and is usually the default shell.

## Features ##

* Built for the command-line operator from the ground up with remote SSH shell environments in mind.
* Supports 3 operating systems (Linux, Solaris/SunOS, OSX/Darwin)
* Themeable - comes with several themes to beautify your shell prompt, and you can write your own.
* Extensible - comes with many plugins to enhance your environments and enrich your command-line experience whether remote or local, and you can write your own!
* Cascades 3-levels of shell customization in order [Global, OS, Host]

## Overview ##

After installing **Bash.env** locally whenever you start a new command prompt, using whatever terminal program you desire, **Bash.env** gets loaded like this:

![Overview](https://raw.github.com/midwire/.env/develop/overview.png)

Lastly, your chosen theme gets loaded and you are ready for an awesome Bash session.

## Install ##

I recommend you fork the project in GitHub, so that your changes can be easily incorporated back into the tree.

### Forked Installation ###

First, click on the "Fork" button on the github homepage: [https://github.com/midwire/bash.env](https://github.com/midwire/bash.env).

Clone the project into your home directory:

    cd $HOME
    git clone git://github.com/<your github username>/bash.env.git

Source it:

    . $HOME/.env/bash.env.sh

### Standard Installation ###

    cd $HOME
    git clone git://github.com/midwire/bash.env.git

Source it:

    . $HOME/.env/bash.env.sh

### Load on Login ###

To have **Bash.env** load automatically, execute:

    bash.env load_bash_env_on_login
    # or simply...
    load_on_login

... which will add the above source command to your `.bashrc` file.

### Load on Alias ###

To have **Bash.env** load with an alias, execute:

    bash.env load_bash_env_on_alias
    # or simply...
    load_on_alias

... which will setup the `ees` alias which will source **Bash.env** whenever you enter `ees` after logging in.  I use this method on all of my remote hosts that are used by other people, besides myself.  That way they don't notice any difference when they login unless they run `ees`.

### Example .bashrc ###

    # Choose your plugins
    plugins="completion history"

    # Choose a Bash.env theme
    theme=sparkr

    # Set my home host.
    # So that when we login to a remote box our theme can change
    # to the remote version with special colors, etc
    dot_env_home_host='spark.local'

    # Set this to zero to avoid the verbosity on starting a new shell instance
    dot_env_verbose=1

    # Source the Bash.env environment
    [[ -r "$HOME/.env/bash.env.sh" ]] && . "$HOME/.env/bash.env.sh"

## Customize your local environment ##

    bash.env config

... which will create a folder in the `host` directory specifically for your local environment and stub out some empty files that you should customize.

The convention is, `$HOME/.env/host/[your-hostname]` directory contains files like these:

* alias.sh
* env.sh
* functions.sh
* prompt.sh

... and anything else you wish to customize your own local environment.

You can put any `*.sh` files in your host directory that you want, and they will only get sourced when you start a Bash shell on the machine matching the specified hostname directory.

This command, `bash.env config` is idempotent, so it will not overwrite or otherwise modify any existing files in your host directory.

### Example: ###

Let's say your hostname is `Harry-Potters-Macbook.local`, and you want to add `/usr/local/bogus` to your path.  Here's how you do it:

    bash.env config

This command will stub out a few files as examples in the directory `$HOME/.env/host/Harry-Potters-Macbook.local`.  Now you can edit each of those files,  delete the ones you don't need and add others if you wish.  So, since we are only going to add to the path let's remove the other files, then edit the path.sh file.

    # Optionally, remove these empty files if you don't need them
    rm alias.sh env.sh functions.sh prompt.sh

Inside `path.sh` add this line:

    pathmunge "/usr/local/bogus"

Done!

Now you can source those changes `. $HOME/.env/bash.env.sh`, or by typing `ees` and your path will include the new entry.  Next time you start a shell it will maintain your path and you'll never have duplicates.

## Themes ##

**Bash.env** themes are located in `$dot_env_path/themes/`.  To use a theme set `theme='THEME_NAME'`. e.g.,

    # In $HOME/.bashrc
    theme='sparkr'

A variant of the `sparkr` theme is default and will be loaded if no theme is specified.  Note that this theme looks best when using the Menlo font.

Please send me a pull request if you create your own themes.

## Other Useful Functions ##

### Add your SSH key to a remote host ###

    bash.env add_ssh_key_to [user@]HOSTNAME

... which will append your public `~/.ssh/id_dsa.pub` key to the host's authorized_keys file and allow you to login without a password.

### Propagate your copy of .env to other hosts ###

If you want to copy your .env to another host, simply type:

    bash.env add_bash_env_to [user@]HOSTNAME

... which will compress your local **Bash.env**, copy it to the specified host and decompress it. Then follow the instructions above under "Load on Login", or "Load on Alias"

If you want to customize the remote host environment even further:

* Run `bash.env config_host HOSTNAME`
* Edit the newly created environment files
* Then `bash.env add_bash_env_to HOSTNAME`

To determine the correct `HOSTNAME` to use for your remote environment make sure you first login to that environment and type `echo $HOSTNAME`.

## Make it better

Please feel free to fork it, branch it, change it and send me a pull request.

Cheers,

-- Midwire
