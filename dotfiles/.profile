# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ] && [ -z "${ALLYPOST_SCRIPT_BASH_INCLUDED:-}" ]; then
	export ALLYPOST_SCRIPT_BASH_INCLUDED=true
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
	export XDG_CONFIG_HOME="$HOME/.config"
	mkdir -p $XDG_CONFIG_HOME
fi

if [ -z "$XDG_CACHE_HOME" ]; then
	export XDG_CACHE_HOME="$HOME/.cache"
	mkdir -p "$XDG_CACHE_HOME"
fi

if [ -z "$XDG_DATA_HOME" ]; then
	export XDG_DATA_HOME="$HOME/.local/share"
	mkdir -p "$XDG_DATA_HOME"
fi

if [ -z "$XDG_STATE_HOME" ]; then
	export XDG_STATE_HOME="$HOME/.local/state"
	mkdir -p "$XDG_STATE_HOME"
fi

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "/opt/cuda/bin/" ]; then
	export PATH="$PATH:/opt/cuda/bin/"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Add homebrew to path if it exists
if [ -d '/opt/homebrew/bin' ]; then
	export PATH="$PATH:/opt/homebrew/bin"
fi

# Add texlive studio thingy if it exists
if [ -d "/opt/texlive/2022/bin/x86_64-linux" ]; then
	PATH="/opt/texlive/2022/bin/x86_64-linux:$PATH"
	MANPATH="/opt/texlive/2022/texmf-dist/doc/man:$MANPATH"
	INFOPATH="/opt/texlive/2022/texmf-dist/doc/info:$INFOPATH"
fi

# Set NPM bin path
NPM_BIN_PATH=''
if [ -d "$HOME/.npm/bin" ]; then
	NPM_BIN_PATH="$HOME/.npm/bin"
	PATH="$PATH:$NPM_BIN_PATH"
fi

if [ -d "$HOME/.local/npm/bin" ]; then
	NPM_BIN_PATH="$HOME/.local/npm/bin"
	PATH="$PATH:$NPM_BIN_PATH"
fi

if [ ! -z "$NPM_BIN_PATH" ]; then
	command -v npm &>/dev/null && npm config set prefix "$(dirname $NPM_BIN_PATH)"
fi

# set PATH so it includes the user's platform tools (ADB) if it exists
if [ -d "$HOME/.local/platform-tools" ]; then
	PATH="$HOME/.local/platform-tools:$PATH"
fi

# set PATH so it includes user's private scripts if it exists
if [ -d "$HOME/.scripts" ]; then
	PATH="$HOME/.scripts:$PATH"
fi

if [ -d "$HOME/.config/composer/vendor/bin" ]; then
	PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi

if [ -d "/snap/bin" ]; then
	PATH="/snap/bin:$PATH"
fi

if [ -d "$HOME/.local/surrealdb" ]; then
	PATH="$PATH:$HOME/.local/surrealdb"
fi

export FLYCTL_INSTALL="$HOME/.local/fly"
if [ -d "$FLYCTL_INSTALL/bin" ]; then
	PATH="$PATH:$FLYCTL_INSTALL/bin"
fi

if [ -d '/opt/nvim-linux64/bin' ]; then
	PATH="/opt/nvim-linux64/bin:$PATH"
fi

if [ -d "$XDG_DATA_HOME/gem/ruby/3.0.0/bin" ]; then
	PATH="$PATH:$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
fi

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LC_TIME='hr_HR.UTF-8'

export VISUAL=vim
export EDITOR="$VISUAL"

export ERL_AFLAGS="-kernel shell_history enabled"

export WORKON_HOME="$HOME/.virtualenvs"

[ -f "$HOME/.local/.profile" ] && source "$HOME/.local/.profile"

export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

	NVM_NODE_DIR="$NVM_DIR/versions/node"
	if [ -d "$NVM_NODE_DIR" ]; then
		declare -a NODE_GLOBALS=($(find "$NVM_NODE_DIR" -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq))

		NODE_GLOBALS+=("node")
		NODE_GLOBALS+=("nvm")
		NODE_GLOBALS+=("yarn")

		load_nvm() {
			export NVM_DIR=~/.nvm
			[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                    # This loads nvm
			[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
		}

		for cmd in "${NODE_GLOBALS[@]}"; do
			eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
		done
	fi
fi

if [ -d "/usr/local/go/bin" ]; then
	export PATH="$PATH:/usr/local/go/bin"
	export GOPATH="$HOME/.local/etc/go"
	mkdir -p "$GOPATH"
fi

if [ -d "$HOME/.emacs.d/bin" ]; then
	export PATH="$PATH:$HOME/.emacs.d/bin"
fi

export GOPATH="$HOME/.local/go"
export PATH="$PATH:$HOME/.local/go/bin"

if [ -d "$HOME/.dotnet" ]; then
	export DOTNET_ROOT="$HOME/.dotnet"
	export PATH="$PATH:$DOTNET_ROOT"
fi

export QT_STYLE_OVERRIDE=kvantum-dark
export QT_QPA_PLATFORMTHEME=qt5ct

# export DOCKER_BUILDKIT=1
# export COMPOSE_DOCKER_CLI_BUILD=1

if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

if [ -f "$HOME/.local/share/JetBrains/Toolbox/scripts" ]; then
	export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi

if [ -f "$HOME/.cargo/bin" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

# Screen locker config
export XSECURELOCK_SHOW_DATETIME=1
# export XSECURELOCK_SAVER=saver_xscreensaver

export SPACEMACSDIR="$XDG_CONFIG_HOME/spacemacs"

# Colored man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Rust stuff
if command -v sccache &>/dev/null; then
	export RUSTC_WRAPPER='sccache'
fi

if [ -z "$RIPGREP_CONFIG_PATH" ]; then
	RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
	if [ -f "$RIPGREP_CONFIG_PATH" ]; then
		export RIPGREP_CONFIG_PATH="$RIPGREP_CONFIG_PATH"
	fi
fi

if [ -d "$HOME/.rd/bin" ]; then
	export PATH="$PATH:$HOME/.rd/bin"
fi
