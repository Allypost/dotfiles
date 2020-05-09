# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
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

export LANGUAGE='en_GB.UTF-8'
export LANG='en_GB.UTF-8'
export LC_ALL='en_GB.UTF-8'
export LC_TIME='hr_HR.UTF-8'

export ERL_AFLAGS="-kernel shell_history enabled"

export WORKON_HOME="$HOME/.virtualenvs"

[ -f "$HOME/.local/.profile" ] && source "$HOME/.local/.profile"

export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
    declare -a NODE_GLOBALS=($(find "$NVM_DIR/versions/node" -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq))

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

export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
fi

if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
    export GOPATH="$HOME/.local/etc/go"
    mkdir -p "$GOPATH"
fi
