# .env

**Version: 0.3.15**

.env (Dot-Env) is a comprehensive, cascading Bash environment system.  It provides Bash shell-prompt themes, handy functions, aliases, and tools for the Bash power user.

I work on many different machines remotely using SSH. Though I love Z-shell, it does not come standard on most operating systems and has to be installed manually.  This can be problematic on Solaris machines or any environment where you don't have rights to install new software.  After using Z-shell for a few months I decided to go back to Bash because it comes standard on all operating systems and is usually the default shell.

## Features ##

* Built for the command-line operator from the ground up with remote SSH shell environments in mind.
* Supports 3 operating systems (Linux, Solaris/SunOS, OSX/Darwin)
* Themeable - comes with several themes to beautify your shell prompt, and you can write your own!
* Extensible - comes with many plugins to enhance your environments and enrich your command-line experience whether remote or local, and you can write your own!

## Overview ##

After installing .env locally whenever you start a new command prompt, using whatever terminal program you desire, .env gets loaded like this:

![Overview](https://raw.github.com/midwire/.env/develop/dot-env-overview.png)

Lastly, your chosen theme gets loaded and you are ready for an awesome Bash session.

## Install ##

I recommend you fork the project in GitHub, so that your changes can be easily incorporated back into the tree.

### Forked Installation ###

First, click on the "Fork" button on the github homepage: https://github.com/midwire/.env.

Clone the project into your home directory:

    cd $HOME
    git clone git://github.com/<your github username>/.env.git

Source it:

    . $HOME/.env/dot-env.sh

### Standard Installation ###

    cd $HOME
    git clone git://github.com/midwire/.env.git

Source it:

    . $HOME/.env/dot-env.sh

### Load on Login ###

To have .env load automatically, execute:

    load_on_login

... which will add the above source command to your `.bashrc` file.

### Load on Alias ###

To have .env load with an alias, execute:

    load_on_alias

... which will setup the `ees` alias which will source .env whenever you enter `ees` after logging in.  I use this method on all of my remote hosts that are used by other people, besides myself.  That way they don't notice any difference when they login unless they run `ees`.

### Example .bashrc ###

    # Choose your plugins
    plugins="completion history"

    # Choose a .env theme
    theme=sparkr

    # Set my home host.
    # So that when we login to a remote box our theme can change
    # to the remote version with special colors, etc
    dot_env_home_host='spark.local'

    # Set this to zero to avoid the verbosity on starting a new shell instance
    dot_env_verbose=1

    # Source the .env environment
    [[ -r "$HOME/.env/dot-env.sh" ]] && . "$HOME/.env/dot-env.sh"

## Customize your local environment ##

    configthis.env

... which will create a folder in the `host` directory specifically for your local environment and stub out some empty files that you should customize.

The convention is, `$HOME/.env/host/[your-hostname]` directory contains files like these:

* alias.sh
* env.sh
* functions.sh
* prompt.sh

... and anything else you wish to customize your own local environment.

You can put any `*.sh` files in your host directory that you want, and they will only get sourced when you start a Bash shell on the machine matching the specified hostname directory.

### Example: ###

Let's say your hostname is `Harry-Potters-Macbook.local`, and you want to add `/usr/local/bogus` to your path.  Here's how you do it:

    configthis.env

This command will stub out a few files as examples and `cd` to the directory where they are `$HOME/.env/host/Harry-Potters-Macbook.local`.  Now you edit each of those files, and delete the ones you don't need.  So, since we are only going to add to the path let's remove the other files, then edit the path.sh file.

    rm alias.sh env.sh functions.sh prompt.sh

Inside `path.sh` add this line:

    pathmunge "/usr/local/bogus"

Done!

Now you can source those changes `. $HOME/.env/dot-env.sh` and your path will include the new entry.  Next time you start a shell it will maintain your path and you'll never have duplicates.

## Themes ##

.env themes are located in `$dot_env_path/themes/`.  To use a theme set `theme='THEME_NAME'`. e.g.,

    theme='sparkr'

A variant of the `sparkr` theme is default and will be loaded if no theme is specified.  Note that this theme looks best when using the Menlo font.

Please send me a pull request if you create your own themes.

## Other Useful Functions ##

### Add your SSH key to a remote host ###

    add_ssh_key_to_host [user@]HOSTNAME

... which will append your public `~/.ssh/id_dsa.pub` key to the host's authorized_keys file and allow you to login without a password.

### Propagate your copy of .env to other hosts ###

If you want to copy your .env to another host, simply type:

    propagate_env_to_host [user@]HOSTNAME

... which will compress your local .env, copy it to the specified host and decompress it. Then follow the instructions above under "Load on Login", or "Load on Alias"

If you want to customize the remote host environment even further:

* Run `confighost.env HOSTNAME`
* Edit the newly created environment files
* Then `propagate_env_to_host HOSTNAME`

To determine the correct `HOSTNAME` to use for your remote environment make sure you first login to that environment and type `echo $HOSTNAME`.

## Make it better

Please feel free to fork it, branch it, change it and send me a pull request.

Cheers,

-- Midwire
