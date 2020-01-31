# If not running interactively, don't change anything
[[ $- != *i* ]] && return

[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# Enable colours and change prompt
autoload -U colors && colors

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# autocomplete aliases
setopt completealiases

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
HISTFILE=~/.zsh_history

# Use modern completion system
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit

zmodload zsh/complist

# Properly use SSH configs
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*:ssh:*' hosts off

compinit -i
_comp_options+=(globdots)

export VISUAL=vim
export EDITOR="$VISUAL"

# Add cool (manpage) colours
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[1;0m'
export LESS_TERMCAP_se=$'\e[1;0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[1;0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Fix for backspace sometimes not working
bindkey "^?" backward-delete-char

# Control left/right deletes word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Ctrl+U deletes to start of line
bindkey "^U" backward-kill-line

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
if [ -d "$HOME/.zfunctions" ]; then
  fpath=($fpath "$HOME/.zfunctions")
fi

# Antigen (Package manager)
if [ -f "$HOME/.zsh-scripts/antigen.zsh" ]; then
  source "$HOME/.zsh-scripts/antigen.zsh"

  antigen use oh-my-zsh

  antigen bundle git
  antigen bundle git-prompt
  antigen bundle command-not-found
  antigen bundle catimg

  antigen bundle "zsh-users/zsh-syntax-highlighting"
  antigen bundle "MichaelAquilina/zsh-you-should-use"
  antigen bundle "olivierverdier/zsh-git-prompt"

  # antigen theme "denysdovhan/spaceship-prompt"
  antigen theme https://github.com/pascaldevink/spaceship-zsh-theme spaceship

  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_TIME_SHOW=true
  SPACESHIP_DIR_TRUNC=0
  SPACESHIP_USER_PREFIX='| '
  SPACESHIP_USER_SUFFIX=''
  SPACESHIP_TIME_PREFIX='| '
  SPACESHIP_DIR_PREFIX='| '
  SPACESHIP_GIT_PREFIX='| '
  SPACESHIP_HOST_PREFIX='@'
  SPACESHIP_DIR_TRUNC_PREFIX='×'
  SPACESHIP_CHAR_SYMBOL='❯'
  SPACESHIP_CHAR_SUFFIX=' '
  SPACESHIP_EXEC_TIME_PREFIX='| took '

  plugins=(git-prompt)

  SPACESHIP_PROMPT_ORDER=(
    user          # Username section
    host          # Hostname section
    time          # Time stamps section
    dir           # Current directory section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    package       # Package version
    node          # Node.js section
    ruby          # Ruby section
    elixir        # Elixir section
    xcode         # Xcode section
    swift         # Swift section
    golang        # Go section
    php           # PHP section
    rust          # Rust section
    haskell       # Haskell Stack section
    julia         # Julia section
    docker        # Docker section
    aws           # Amazon Web Services section
    venv          # virtualenv section
    conda         # conda virtualenv section
    pyenv         # Pyenv section
    dotnet        # .NET section
    ember         # Ember.js section
    terraform     # Terraform workspace section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
  )

  SPACESHIP_PACKAGE_SHOW=false
  SPACESHIP_NODE_SHOW=false
  SPACESHIP_RUBY_SHOW=false
  SPACESHIP_ELM_SHOW=false
  SPACESHIP_ELIXIR_SHOW=false
  SPACESHIP_GOLANG_SHOW=false
  SPACESHIP_PHP_SHOW=false
  SPACESHIP_RUST_SHOW=false
  SPACESHIP_HASKELL_SHOW=false
  SPACESHIP_JULIA_SHOW=false
  SPACESHIP_DOCKER_SHOW=false
  SPACESHIP_DOCKER_CONTEXT_SHOW=false
  SPACESHIP_AWS_SHOW=false
  SPACESHIP_DOTNET_SHOW=false
  SPACESHIP_EMBER_SHOW=false
  SPACESHIP_KUBECTL_SHOW=false
  SPACESHIP_EXIT_CODE_SHOW=true

  antigen apply
fi
