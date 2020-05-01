# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

  antigen theme romkatv/powerlevel10k

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

  antigen apply
fi
