# Bash.env

**Version: 1.0.1**

**Bash.env** is a cascading Bash environment system.  It provides Bash shell-prompt themes, handy functions, aliases, and tools for the Bash power user.

Z-shell is great, but it does not come standard on most operating systems.  This can be problematic in an environment where you don't have administrative rights.

Not all development environments are the same. **Bash.env** lets you customize your Bash environment at 3 levels. Globals load first, then operating system customizations and lastly specifics for the particular host you are working on.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Bash.env](#bashenv)
	- [Features](#features)
	- [Overview](#overview)
	- [Install](#install)
		- [Forked Installation (recommended)](#forked-installation-recommended)
		- [Standard Installation](#standard-installation)
		- [Load on Login](#load-on-login)
		- [Load on Alias](#load-on-alias)
		- [Example .bashrc](#example-bashrc)
	- [Customize your local environment](#customize-your-local-environment)
		- [Example:](#example)
	- [Themes](#themes)
	- [Other Useful Functions](#other-useful-functions)
		- [Add your SSH key to a remote host](#add-your-ssh-key-to-a-remote-host)
		- [Propagate your copy of Bash.env to other hosts](#propagate-your-copy-of-bashenv-to-other-hosts)
	- [Make it better](#make-it-better)

<!-- /TOC -->

## Features

* Built for the Bash command-line operator from the ground up, with remote SSH environments in mind.
* Supports 3 operating systems (Linux, Solaris/SunOS, OSX/Darwin). _Win-bash or Cygwin may work also but they are untested._
* Themeable - comes with several themes to beautify your shell prompt, and you can write your own.
* Extensible - comes with many plugins to enhance your environments and enrich your command-line experience whether remote or local, and it is easy to write your own!
* Cascades 3-levels of shell customization in order [Global, OS, Host]. Configure specifics for all environments at the Global level. Configure all Linux, OSX and Solaris environments at the OS level. Set specific and detailed customizations at the Host level.

## Overview

After installing **Bash.env**, whenever you start a new command prompt **Bash.env** gets loaded like this:

![Overview](https://raw.github.com/midwire/.env/develop/overview.png)

Lastly, your chosen theme gets loaded and you are ready for an awesome Bash session!

## Install

If you fork the project in GitHub your customizations can be easily incorporated back into the master branch here.

### Forked Installation (recommended)

First, click on the "Fork" button on the github homepage: [https://github.com/midwire/bash.env](https://github.com/midwire/bash.env).

Clone your forked copy into your home directory:

    cd $HOME
    git clone git://github.com/<your_github_username>/bash.env.git .env

Source it:

    . $HOME/.env/bash.env.sh

### Standard Installation

    cd $HOME
    git clone git://github.com/midwire/bash.env.git .env

Source it:

    . $HOME/.env/bash.env.sh

### Load on Login

To have **Bash.env** load automatically, execute:

    bash.env load_bash_env_on_login
    # or simply...
    load_on_login

... which will add the above "Source" command to your `.bashrc` file.

### Load on Alias

To have **Bash.env** load with an alias, execute:

    bash.env load_bash_env_on_alias bashenv
    # or simply...
    load_on_alias bashenv

... which will setup the `bashenv` alias which will source **Bash.env** whenever you enter `bashenv` after logging in.  Use this method for shared remote accounts that are used by other people. Use any alias name you want in place of `bashenv`.

### Example .bashrc

    # Choose your plugins
    plugins="completion history"

    # Choose a Bash.env theme
    theme=transwarp

    # Set home host, so that when we login to a remote box our theme can change
    # to the remote version with special colors, etc
    dot_env_home_host='spark.local'

    # Set this to zero to avoid the verbosity on starting a new shell instance
    dot_env_verbose=1

    # Source the Bash.env environment
    [[ -r "$HOME/.env/bash.env.sh" ]] && . "$HOME/.env/bash.env.sh"

## Customize your local environment

    bash.env config

... which will create a folder in the `host` directory specifically for your local environment and stub out some empty files which you can customize.

The convention is, `$HOME/.env/host/[your-hostname]` directory contains files like these:

* alias.sh
* env.sh
* functions.sh
* prompt.sh

... and anything else you need to customize your own local environment.

You can put any `*.sh` files in your host directory that you want, and they will only get sourced when you start a Bash shell on the machine matching the specified hostname directory.

This command, `bash.env config` is idempotent, so it will not overwrite or otherwise modify any existing files in your host directory.

### Example:

Let's say your hostname is `Harry-Potters-Macbook.local`, and you want to add `/usr/local/bogus` to your path every time you startup a Bash session.  Here's how you do it:

    bash.env config

This command will stub out a few files as examples in the directory `$HOME/.env/host/Harry-Potters-Macbook.local`.  Now you can edit each of those files,  delete the ones you don't need and add others if you wish.  So, since we are only going to add to the path let's remove the other files, then edit the path.sh file.

    # Optionally, remove these empty files if you don't need them
    rm alias.sh env.sh functions.sh prompt.sh

Inside `path.sh` add this line:

    pathmunge "/usr/local/bogus"

Done!

Now you can source those changes `. $HOME/.env/bash.env.sh`.  Next time you start a shell it will maintain your path and you'll never have duplicates.

## Themes

**Bash.env** themes are located in `$dot_env_path/themes/`.  To use a theme set `theme='THEME_NAME'`. e.g.,

    # In $HOME/.bashrc
    theme='transwarp'

A variant of the `transwarp` theme is default and will be loaded if no theme is specified.

Please send me a pull request if you create your own themes.

## Other Useful Functions

### Add your SSH key to a remote host

    bash.env add_ssh_key_to [user@]HOSTNAME

... which will append your public `~/.ssh/id_dsa.pub` key to the host's authorized_keys file and allow you to login without a password.

### Propagate your copy of Bash.env to other hosts

If you want to copy your local Bash.env to another host, simply type:

    bash.env add_bash_env_to [user@]HOSTNAME

or

    propagate_env_to_host [user@]HOSTNAME

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
