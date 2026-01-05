# Bash.env

**Version: 1.1.2**

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
	- [Plugins](#plugins)
		- [Lazy Loading](#lazy-loading)
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

![Overview](https://raw.githubusercontent.com/midwire/bash.env/master/overview.png)

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
    plugins="completion history git nvm rbenv"

    # Choose a Bash.env theme
    theme=transwarp

    # Set home host, so that when we login to a remote box our theme can change
    # to the remote version with special colors, etc
    dot_env_home_host='spark.local'

    # Set this to zero to avoid the verbosity on starting a new shell instance
    dot_env_verbose=1

    # Optional: Disable lazy loading for version managers (they load immediately)
    # NVM_LAZY=0
    # RBENV_LAZY=0
    # PYENV_LAZY=0
    # CHRUBY_LAZY=0

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

## Plugins

**Bash.env** comes with many plugins to enhance your shell experience. Enable plugins by adding them to the `plugins` variable in your `.bashrc` before sourcing **Bash.env**:

    plugins="completion history git nvm rbenv pyenv fzf"

Available plugins include:

| Plugin | Description |
|--------|-------------|
| `completion` | Bash completion support |
| `history` | Enhanced history settings |
| `git` | Git aliases and completions |
| `nvm` | Node Version Manager |
| `rbenv` | Ruby version manager |
| `pyenv` | Python version manager |
| `chruby` | Lightweight Ruby version manager |
| `fzf` | Fuzzy finder integration |
| `docker` | Docker aliases |
| `homebrew` | Homebrew setup (macOS) |
| `ssh` | SSH agent management |

See the `plugins/` directory for all available plugins.

### Lazy Loading

Version manager plugins (`nvm`, `rbenv`, `pyenv`, `chruby`) use **lazy loading** by default to speed up shell startup time. Instead of initializing immediately, they wait until you first use a related command.

For example, with the `nvm` plugin, the actual nvm initialization is deferred until you run `nvm`, `node`, `npm`, `npx`, `yarn`, or similar commands.

**Lazy-loaded commands by plugin:**

| Plugin | Commands |
|--------|----------|
| `nvm` | `nvm`, `node`, `npm`, `npx`, `yarn`, `pnpm`, `corepack` |
| `rbenv` | `rbenv`, `ruby`, `gem`, `bundle`, `irb`, `rake`, `rails`, `rspec` |
| `pyenv` | `pyenv`, `python`, `python3`, `pip`, `pip3`, `pydoc` |
| `chruby` | `chruby`, `ruby`, `gem`, `bundle`, `irb`, `rake`, `rails`, `rspec` |

**Disabling lazy loading:**

If you need the version manager to initialize immediately (e.g., for scripts that check versions at startup), disable lazy loading by setting the appropriate variable before sourcing **Bash.env**:

    # Disable lazy loading for nvm
    NVM_LAZY=0

    # Disable lazy loading for rbenv
    RBENV_LAZY=0

    # Disable lazy loading for pyenv
    PYENV_LAZY=0

    # Disable lazy loading for chruby
    CHRUBY_LAZY=0

    plugins="nvm rbenv"
    [[ -r "$HOME/.env/bash.env.sh" ]] && . "$HOME/.env/bash.env.sh"

## Other Useful Functions

### Add your SSH key to a remote host

    bash.env add_ssh_key_to [user@]HOSTNAME

... which will append your public `~/.ssh/id_dsa.pub` key to the host's authorized_keys file and allow you to login without a password.

    bash.env add_ssh_key_to [user@]HOSTNAME [PUBLIC_KEYFILE_PATH]
    
... as above, using the specified public key.

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
