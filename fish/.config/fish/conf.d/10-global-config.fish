set --global Z_DATA "$HOME/.local/bash/z.db"

set --global TERM xterm-256color

#set --global DOCKER_BUILDKIT 1
#set --global COMPOSE_DOCKER_CLI_BUILD 1

# Colored man pages
set -xU MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -xU MANROFFOPT '-P -c'

# Screen locker config
set --global XSECURELOCK_SHOW_DATETIME 1
# set --global XSECURELOCK_SAVER saver_xscreensaver
set --global SPACEMACSDIR "$XDG_CONFIG_HOME/spacemacs"
