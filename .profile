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
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes the user's platform tools (ADB) if it exists
if [ -d "$HOME/.local/platform-tools" ]; then
    PATH="$HOME/.local/platform-tools:$PATH"
fi

# set PATH so it includes user's private scripts if it exists
if [ -d "$HOME/.scripts" ] ; then
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