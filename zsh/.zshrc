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

# ignore commands that start with a space (don't save to history)
setopt HIST_IGNORE_SPACE

# autocomplete aliases
setopt completealiases

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
HISTFILE=~/.zsh_history

# Add completions
if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh

  fpath=("$ASDF_DIR/completions" $fpath)
fi

if [ -d "$HOME/.zsh/completions" ]; then
  fpath=($fpath "$HOME/.zsh/completions")
fi

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

# Make it so Ctrl+L also clears scrollback buffer
function clear-scrollback-buffer {
  # Behavior of clear: 
  # 1. clear scrollback if E3 cap is supported (terminal, platform specific)
  # 2. then clear visible screen
  # For some terminal 'e[3J' need to be sent explicitly to clear scrollback
  clear && printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle && zle .reset-prompt && zle -R
}
zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer

# Antigen (Package manager)
if [ -f "$HOME/.zsh-scripts/antigen.zsh" ]; then
  source "$HOME/.zsh-scripts/antigen.zsh"

  antigen use oh-my-zsh
	
  ### Bundles

  ## Loaded from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
  antigen bundle git
  antigen bundle git-prompt
  antigen bundle command-not-found
  antigen bundle gitfast
  antigen bundle sudo


  ## Loaded from other sources
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle hlissner/zsh-autopair
  # antigen bundle "zsh-users/zsh-syntax-highlighting"
  antigen bundle zdharma-continuum/fast-syntax-highlighting
  antigen bundle MichaelAquilina/zsh-you-should-use
  antigen bundle olivierverdier/zsh-git-prompt
  antigen theme romkatv/powerlevel10k


  ## Program dependant bundles
  if command -v fd >/dev/null 2>&1; then
    antigen bundle fd
  fi
  if command -v fzf >/dev/null 2>&1; then
    antigen bundle fzf

    export FZFZ_PREVIEW_COMMAND='tree -NC -L 2 -x --noreport --dirsfirst {}'
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --hidden --files || find ."
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
    export FZF_ALT_C_OPTS="--preview 'tree -NC {} | head -200'"
  fi



  ### Load p10k configs
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"



  # Local customizations, e.g. theme, plugins, aliases, etc.
  [ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

  antigen apply
fi

if [ -f "$HOME/.local/bash/z/z.sh" ]; then
  _Z_DATA="$HOME/.local/bash/z.db"
  . "$HOME/.local/bash/z/z.sh"
fi

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
if [ -d "$HOME/.zfunctions" ]; then
  fpath=($fpath "$HOME/.zfunctions")
fi
