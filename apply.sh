#!/usr/bin/env bash

SCRIPTPATH="$(
	cd "$(dirname "$0")" >/dev/null 2>&1
	pwd -P
)"
SCRIPTS_DIR="$HOME/.scripts"
ANTIGEN_LOC="$HOME/.zsh-scripts/antigen.zsh"
ASDF_LOC="$HOME/.asdf"
EMACS_CONF_DIR="$HOME/.emacs.d"

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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

TMUX_PLUGINS_DIR="${XDG_CONFIG_HOME:-"$HOME/.config"}/tmux/plugins"
TMUX_TPM_DIR="$TMUX_PLUGINS_DIR/tpm"
echo "Installing tmux plugin manager..."
if [[ -d "$TMUX_TPM_DIR" ]]; then
	echo "Tmux TPM already installed... Skipping."
else
	echo "Installing Tmux TPM..."
	git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
	. "$TMUX_TPM_DIR/bin/install_plugins"
fi

# Remove completions for some programs

# runit
if ! command -v sv &>/dev/null; then
	[ -f '/usr/share/zsh/functions/Completion/Unix/_runit' ] && sudo mv /usr/share/zsh/functions/Completion/Unix/{,.bak-}_runit || echo 'Runit alias removed'
fi
