#!/usr/bin/env bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)"
SCRIPTS_DIR="$HOME/.scripts"
ANTIGEN_LOC="$HOME/.zsh-scripts/antigen.zsh"
ASDF_LOC="$HOME/.asdf"
EMACS_CONF_DIR="$HOME/.emacs.d"

# Run GNU stow to symlink everything
stow */

source "$HOME/.profile"

echo "Downloading scripts..."
if [[ -d "$SCRIPTS_DIR" || -f "$SCRIPTS_DIR" ]]; then
    echo "Scripts directort already exists... Skipping."
else
    git clone https://github.com/Allypost/bash-scripts.git "$SCRIPTS_DIR"
fi

echo "Installing antigen..."
if [[ -f "$ANTIGEN_LOC" ]]; then
    echo "Antigen already installed... Skipping."
else
    mkdir -p "$(dirname "$ANTIGEN_LOC")"
    curl -L git.io/antigen >"$ANTIGEN_LOC"
fi

echo "Installing asdf..."
if [[ -d "$ASDF_LOC" ]]; then
    echo "asdf already installed... Skipping."
else
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_LOC"
    cd "$ASDF_LOC"
    git checkout "$(git describe --abbrev=0 --tags)"
    cd -
fi

# Remove completions for some programs

# runit
if ! command -v sv &>/dev/null; then
    [ -f '/usr/share/zsh/functions/Completion/Unix/_runit' ] && sudo mv /usr/share/zsh/functions/Completion/Unix/{,.bak-}_runit || echo 'Runit alias removed'
fi
