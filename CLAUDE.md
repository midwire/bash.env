# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Bash.env is a cascading Bash environment system providing shell-prompt themes, functions, aliases, and tools. It supports Linux, macOS (Darwin), and SunOS.

## Key Commands

```bash
# Version management (uses Rakefile)
rake bump_patch      # Increment patch version and update CHANGELOG
rake bump_minor      # Increment minor version
rake bump_major      # Increment major version
rake changes         # Write changes to CHANGELOG interactively

# CLI tool (after sourcing bash.env.sh)
bash.env config      # Configure host-specific environment
bash.env update      # Update to latest version
bash.env help        # Show available commands
```

## Architecture

### Loading Order (cascading system)
1. `bash.env.sh` - Entry point, detects OS
2. `global/global.sh` - Sources all `global/global_*.sh` files
3. `plugins/plugins.sh` - Loads plugins defined in `$plugins` variable
4. `os/{Darwin,Linux,SunOS}/*.sh` - OS-specific configurations
5. `host/$HOSTNAME/*.sh` - Host-specific configurations
6. `themes/load_theme.sh` - Loads theme from `$theme` variable

### Plugin System
- Plugins live in `plugins/<name>/<name>.plugin.sh`
- Enable plugins by setting `plugins="plugin1 plugin2"` in `.bashrc` before sourcing
- Custom plugins can override standard ones via `$dot_env_custom/plugins/`

### Theme System
- Themes live in `themes/<name>/theme.sh`
- Set `theme='themename'` in `.bashrc` before sourcing
- Themes can have `local.sh` and `remote.sh` variants (local vs SSH)
- `$dot_env_home_host` determines which variant loads

### Key Variables
- `$dot_env_path` - Path to bash.env installation
- `$dot_env_custom` - Path to custom overrides (defaults to `$dot_env_path/custom`)
- `$dot_env_verbose` - Set to 1 for verbose loading output
- `$dot_env_home_host` - Your home hostname for theme switching

### Directory Structure
- `global/` - Always-loaded environment (aliases, colors, functions)
- `os/` - OS-specific configurations (Darwin, Linux, SunOS)
- `host/` - Hostname-specific configurations
- `plugins/` - Optional plugin modules
- `themes/` - Prompt themes (default links to transwarp)
- `bin/` - Utility scripts
- `custom/` - User overrides (gitignored)

### Creating Plugins
A plugin file should be named `plugins/<name>/<name>.plugin.sh` and will be sourced when the plugin name is in the `$plugins` variable.

### Lazy Loading
Version manager plugins (nvm, rbenv, pyenv, chruby) use lazy loading by default for faster shell startup. The actual initialization is deferred until the first use of the command. To disable lazy loading for a plugin, set its `*_LAZY` variable to `0` before sourcing bash.env:

```bash
NVM_LAZY=0      # Disable lazy loading for nvm
RBENV_LAZY=0    # Disable lazy loading for rbenv
PYENV_LAZY=0    # Disable lazy loading for pyenv
CHRUBY_LAZY=0   # Disable lazy loading for chruby
```

### Creating Themes
A theme directory at `themes/<name>/` should contain `theme.sh` which sets PS1. Use colors from `themes/load_theme.sh` (wrapped for prompt display). Themes can use `ps1_git_branch`, `ps1_git_status`, `ps1_ruby` helper functions.

## Code Style
- Use `$(command)` instead of backticks
- Use `command -v` instead of `which`
- Use `[[ ]]` for conditionals instead of `[ ]`
- Quote variables: `"$var"` not `$var`
- Check for command existence before use: `command -v brew &>/dev/null`
- Support both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) Homebrew paths
