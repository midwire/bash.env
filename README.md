# Bash.env

**Version: 1.2.0**

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
	- [CLI Commands](#cli-commands)
		- [Plugin Management](#plugin-management)
		- [Search and Discovery](#search-and-discovery)
		- [Theme Preview](#theme-preview)
		- [Diagnostics](#diagnostics)
		- [Profiles](#profiles)
	- [Configuration File](#configuration-file)
	- [Other Useful Functions](#other-useful-functions)
		- [Add your SSH key to a remote host](#add-your-ssh-key-to-a-remote-host)
		- [Propagate your copy of Bash.env to other hosts](#propagate-your-copy-of-bashenv-to-other-hosts)
	- [Testing](#testing)
	- [NO_COLOR Support](#no_color-support)
	- [Make it better](#make-it-better)

<!-- /TOC -->

## Features

* Built for the Bash command-line operator from the ground up, with remote SSH environments in mind.
* Supports 3 operating systems (Linux, Solaris/SunOS, OSX/Darwin). _Win-bash or Cygwin may work also but they are untested._
* Themeable - comes with several themes to beautify your shell prompt, and you can write your own.
* Extensible - comes with many plugins to enhance your environments and enrich your command-line experience whether remote or local, and it is easy to write your own!
* Cascades 3-levels of shell customization in order [Global, OS, Host]. Configure specifics for all environments at the Global level. Configure all Linux, OSX and Solaris environments at the OS level. Set specific and detailed customizations at the Host level.
* CLI management - enable/disable plugins, search components, preview themes, and run diagnostics without editing config files.
* Profile system - save and restore sets of plugin/theme configurations.
* Dynamic completions - automatically sources completions from installed tools.
* Structured logging with configurable levels.

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

    # Choose your plugins (or manage with: bash.env enable/disable)
    plugins="completion history git nvm rbenv"

    # Choose a Bash.env theme (or manage with: bash.env set_theme)
    theme=transwarp

    # Set home host, so that when we login to a remote box our theme can change
    # to the remote version with special colors, etc
    dot_env_home_host='spark.local'

    # Set this to zero to avoid the verbosity on starting a new shell instance
    dot_env_verbose=1

    # Optional: Set log level (error, warn, info, debug). Default: warn
    # dot_env_log_level=info

    # Optional: Set command duration threshold in seconds. Default: 5
    # COMMAND_DURATION_THRESHOLD=3

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

**Bash.env** themes are located in `$dot_env_path/themes/`.  To set a theme:

    # Option 1: In $HOME/.bashrc
    theme='transwarp'

    # Option 2: Using the CLI
    bash.env set_theme transwarp

A variant of the `transwarp` theme is default and will be loaded if no theme is specified.

To preview available themes:

    bash.env preview          # Preview all themes
    bash.env preview kitchen_sink  # Preview a specific theme

To temporarily try a theme in the current session:

    try_theme kitchen_sink    # Switch to a theme
    reset_theme               # Revert to original

Please send me a pull request if you create your own themes.

## Plugins

**Bash.env** comes with many plugins to enhance your shell experience. Enable plugins by adding them to the `plugins` variable in your `.bashrc` before sourcing **Bash.env**, or use the CLI:

    # Option 1: In .bashrc
    plugins="completion history git nvm rbenv pyenv fzf"

    # Option 2: Using the CLI
    bash.env enable fzf
    bash.env disable pyenv

Available plugins include:

| Plugin | Description |
|--------|-------------|
| `autojump` | Directory navigation shortcuts |
| `awscli` | AWS CLI integration |
| `chruby` | Lightweight Ruby version manager (lazy-loadable) |
| `colored_man_pages` | Colorized man page output |
| `command_duration` | Display execution time for long-running commands |
| `completion` | Bash completion support with dynamic tool detection |
| `direnv` | Automatic .envrc loading with direnv |
| `docker` | Docker aliases |
| `editor` | Editor configuration |
| `extract` | Universal archive extraction |
| `fzf` | Fuzzy finder integration |
| `git` | Git aliases and completions |
| `golang` | Go language support |
| `history` | Enhanced history settings |
| `homebrew` | Homebrew setup (macOS) |
| `java` | Java development environment |
| `lunarvim` | LunarVim editor integration |
| `nodejs` | Node.js development tools |
| `nvm` | Node Version Manager (lazy-loadable) |
| `pyenv` | Python version manager (lazy-loadable) |
| `python` | Python development tools |
| `rbenv` | Ruby version manager (lazy-loadable) |
| `ruby` | Ruby language support |
| `rust` | Rust language support |
| `ssh` | SSH agent management |
| `sudo` | Press Esc+Esc to prepend sudo to current command |
| `tmux` | Terminal multiplexer |
| `zoxide` | Smarter directory navigation (z command) |

See the `plugins/` directory for all available plugins, or run `bash.env search` to list them with enabled/disabled status.

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

### Command Duration

The `command_duration` plugin tracks and displays execution time for long-running commands. Enable it and use `ps1_command_duration` in your theme's PS1:

    bash.env enable command_duration

Configure the threshold (default: 5 seconds):

    COMMAND_DURATION_THRESHOLD=3   # Show duration for commands taking 3+ seconds

### Dynamic Completions

The `completion` plugin automatically detects installed tools and sources their built-in completions. Supported tools include: docker, kubectl, helm, terraform, npm, pip, cargo, rustup, gh, AWS CLI, gcloud, minikube, and kind.

No configuration needed — just enable the `completion` plugin and completions are sourced for any installed tools.

## CLI Commands

Run `bash.env help` to see all available commands. Key commands:

### Plugin Management

    bash.env enable <plugin>     # Enable a plugin
    bash.env disable <plugin>    # Disable a plugin
    bash.env reload              # Reload environment to apply changes

### Search and Discovery

    bash.env search              # List all plugins and themes with status
    bash.env search git          # Filter by keyword

### Theme Preview

    bash.env preview             # Preview all themes
    bash.env preview <theme>     # Preview a specific theme
    bash.env set_theme <theme>   # Set the active theme

### Diagnostics

    bash.env doctor              # Show system info and health checks

Reports OS, bash version, enabled plugins, current theme, PATH duplicates, missing plugins, and other potential issues.

### Profiles

Save and restore sets of plugin/theme configurations:

    bash.env profile save work     # Save current config as "work"
    bash.env profile save minimal  # Save a different config as "minimal"
    bash.env profile load work     # Restore the "work" config
    bash.env profile list          # List saved profiles
    bash.env profile delete old    # Delete a profile

## Configuration File

When you use CLI commands like `bash.env enable`, `bash.env disable`, or `bash.env set_theme`, your choices are stored in `~/.bash.env.conf`. This file is optional — if it doesn't exist, `plugins` and `theme` values from `.bashrc` are used as before.

When both `.bashrc` and `~/.bash.env.conf` define `plugins` or `theme`, the config file takes precedence.

**What goes where:**

| Setting | Where |
|---------|-------|
| `plugins`, `theme` | `~/.bash.env.conf` (managed by CLI) or `.bashrc` (manual) |
| `dot_env_verbose`, `dot_env_home_host` | `.bashrc` |
| `dot_env_log_level` | `.bashrc` |
| Lazy loading toggles (`NVM_LAZY`, etc.) | `.bashrc` |
| `COMMAND_DURATION_THRESHOLD` | `.bashrc` |
| `ENABLE_AUTO_UPDATE` | `.bashrc` |

## Logging

**Bash.env** includes structured logging with configurable levels:

    dot_env_log_level=info   # Set in .bashrc (error, warn, info, debug)

Use in plugins or custom scripts:

    dot_env_log info "Loading custom config"
    dot_env_log error "Failed to initialize"
    dot_env_log debug "Variable value: $foo"

Default level is `warn` — only errors and warnings are shown.

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

## Testing

**Bash.env** includes a test suite using [Bats](https://github.com/bats-core/bats-core) and linting via [ShellCheck](https://github.com/koalaman/shellcheck):

    rake test    # Run the Bats test suite
    rake lint    # Run ShellCheck on all shell scripts

Install the tools:

    # Bats
    # See: https://github.com/bats-core/bats-core#installation

    # ShellCheck
    # See: https://github.com/koalaman/shellcheck#installing

## NO_COLOR Support

**Bash.env** respects the [NO_COLOR](https://no-color.org/) convention. When the `NO_COLOR` environment variable is exported, all color output in themes is suppressed:

    export NO_COLOR=1    # Disable colors

## Make it better

Please feel free to fork it, branch it, change it and send me a pull request.

Cheers,

-- Midwire
