#!/usr/bin/env bash

set -eo pipefail

SCRIPTS_DIR="$HOME/.scripts"
ANTIGEN_LOC="$HOME/.zsh-scripts/antigen.zsh"
ASDF_LOC="$HOME/.asdf"
CONFIG_DIR="${XDG_CONFIG_HOME:-"$HOME/.config"}"

# Run GNU stow to symlink everything
stow --verbose --restow */

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

TMUX_PLUGINS_DIR="$CONFIG_DIR/tmux/plugins"
TMUX_TPM_DIR="$TMUX_PLUGINS_DIR/tpm"
echo "Installing tmux plugin manager..."
if [[ -d "$TMUX_TPM_DIR" ]]; then
	echo "Tmux TPM already installed... Skipping."
else
	echo "Installing Tmux TPM..."
	git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
	. "$TMUX_TPM_DIR/bin/install_plugins"
fi

echo "Installing AstroNvim..."
if [ -d "${CONFIG_DIR}/nvim/lua/astronvim" ]; then
	echo "AstroNvim already installed... Skipping."
else
	# Backup old nvim config
	mv ~/.config/nvim ~/.config/nvim.bak || echo -n ""
	mv ~/.local/share/nvim ~/.local/share/nvim.bak || echo -n ""
	mv ~/.local/state/nvim ~/.local/state/nvim.bak || echo -n ""
	mv ~/.cache/nvim ~/.cache/nvim.bak || echo -n ""

	# Clone AstroNvim repository
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$CONFIG_DIR/nvim"

	# Restow nvim config
	stow --verbose --restow vim
	nvim --headless -c 'quitall'
fi

# Remove completions for some programs

# runit
if ! command -v sv &>/dev/null; then
	[ -f '/usr/share/zsh/functions/Completion/Unix/_runit' ] && sudo mv /usr/share/zsh/functions/Completion/Unix/{,.bak-}_runit || echo 'Runit alias removed'
fi
