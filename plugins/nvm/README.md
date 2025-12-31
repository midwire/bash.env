# NVM Plugin

Adds Node Version Manager (nvm) support with lazy loading for faster shell startup.

## Usage

Add `nvm` to your plugin array in `.bashrc`:

```bash
plugins="nvm"
[[ -r $HOME/.env/bash.env.sh ]] && . $HOME/.env/bash.env.sh
```

## Lazy Loading

By default, nvm is lazy-loaded to improve shell startup time. The actual nvm
initialization is deferred until you first use `nvm`, `node`, `npm`, `npx`,
`yarn`, `pnpm`, or `corepack`.

To disable lazy loading and load nvm immediately on shell startup:

```bash
NVM_LAZY=0
plugins="nvm"
[[ -r $HOME/.env/bash.env.sh ]] && . $HOME/.env/bash.env.sh
```

## Installation

If nvm is not installed:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```
