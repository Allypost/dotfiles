#/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOTFILES=\.*
SCRIPTS_DIR="$HOME/.scripts"
ANTIGEN_LOC="$HOME/.zsh-scripts/antigen.zsh"
ASDF_LOC="$HOME/.asdf"
EMACS_CONF_DIR="$HOME/.emacs.d"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
DOOM_EMACS_CONF_DIR="$CONF_DIR/doom"
ROFI_CONF_DIR="$CONF_DIR/rofi"
XFCE4_CONF_DIR="$CONF_DIR/xfce4/"
XFCE4_TERMINAL_CONF_DIR="$XFCE4_CONF_DIR/terminal"
ARIA2_CONF_DIR="$CONF_DIR/aria2"

echo "Adding symlinks to files..."
for f in $DOTFILES; do
    if [[ ! -f "$f" ]]; then
        continue
    fi

    if [[ -L "$HOME/$f" ]]; then
        echo "Removing old symlink to '$f'"
	    rm -i "$HOME/$f"
    fi

    if [[ -f "$HOME/$f" ]]; then
        echo "Backing up: '$f' to '$f.bak'"
        mv "$HOME/$f" "$HOME/$f.bak"
    fi

    ln -rs "$f" "$HOME/$f"
done



echo "Adding configs..."
if [[ -f "$CONF_DIR/kglobalshortcutsrc" ]]; then
    mv "$CONF_DIR/kglobalshortcutsrc" "$CONF_DIR/kglobalshortcutsrc.bak"
fi
ln -rs "$SCRIPTPATH/kde/kglobalshortcutsrc" "$CONF_DIR/kglobalshortcutsrc"

mkdir -p "$ROFI_CONF_DIR"
if [[ -f "$ROFI_CONF_DIR/config.rasi" ]]; then
    mv "$ROFI_CONF_DIR/config.rasi" "$ROFI_CONF_DIR/config.rasi.bak"
fi
ln -rs "$SCRIPTPATH/rofi/config.rasi" "$ROFI_CONF_DIR/config.rasi"
mkdir -p "$ROFI_CONF_DIR/themes/"
if [[ -f "$ROFI_CONF_DIR/themes/slate.rasi" ]]; then
  mv "$ROFI_CONF_DIR/themes/slate.rasi" "$ROFI_CONF_DIR/themes/slate.rasi.bak"
fi
ln -rs "$SCRIPTPATH/rofi/themes/slate.rasi" "$ROFI_CONF_DIR/themes/slate.rasi"


mkdir -p "$XFCE4_CONF_DIR"
if [[ -d "$XFCE4_TERMINAL_CONF_DIR" ]]; then
    echo "XFCE4 terminal config already exists..."
    printf "Do you want to override the existing config? [y/N] "
    read OVERRIDE_XFCE4_TERMINAL

    shopt -s nocasematch
    if [[ $OVERRIDE_XFCE4_TERMINAL =~ (y|yes) ]]; then
        mv "$XFCE4_TERMINAL_CONF_DIR" "$XFCE4_TERMINAL_CONF_DIR.bak"
    fi
    shopt -u nocasematch
fi
ln -rs "$SCRIPTPATH/xfce4/terminal" "$XFCE4_CONF_DIR"


mkdir -p "$ARIA2_CONF_DIR"
if [[ -f "$ARIA2_CONF_DIR/aria2.conf" ]]; then
    echo "Aria2 config already exists..."
    printf "Do you want to override the existing config? [y/N]"
    read OVERRIDE_ARIA2_CONFIG

    shopt -s nocasematch
    if [[ "$OVERRIDE_ARIA2_CONFIG" =~ (y|yes) ]]; then
      mv "$ARIA2_CONF_DIR/aria2.conf" "$ARIA2_CONF_DIR/aria2.conf.bak"
    fi
    shopt -u nocasematch
fi
ln -rs "$SCRIPTPATH/aria2/aria2.conf" "$ARIA2_CONF_DIR"


source "$HOME/.profile"



echo "Downloading scripts..."
if [[ -d "$SCRIPTS_DIR" || -f "$SCRIPTS_DIR" ]]; then
    echo "Scripts directort already exists... Skipping."
else
    git clone https://github.com/Allypost/bash-scripts.git "$SCRIPTS_DIR"
fi



echo "Installing antigen..."
if [[ -f "$ANTIGEN_LOC"  ]]; then
    echo "Antigen already installed... Skipping."
else
    mkdir -p "$(dirname "$ANTIGEN_LOC")"
    curl -L git.io/antigen > "$ANTIGEN_LOC"
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



echo "Installing doom-emacs..."
if [[ -d "$EMACS_CONF_DIR" ]]; then
    echo ".emacs.d already exists..."
    printf "Do you want to override the existing config? [y/N] "
    read OVERRIDE_EMACS
    
    shopt -s nocasematch
    if [[ $OVERRIDE_EMACS =~ (y|yes) ]]; then
        EMACS__INSTALL_DOOM_EMACS=1
    fi
    shopt -u nocasematch
else
    EMACS__INSTALL_DOOM_EMACS=1
fi
if [ ! -z "$EMACS__INSTALL_DOOM_EMACS" ]; then
    rm -rf "$EMACS_CONF_DIR"
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$EMACS_CONF_DIR"
fi

if [ -d "$DOOM_EMACS_CONF_DIR" ]; then
    echo "doom-emacs config already exists..."
    printf "Do you want to override the existing config? [y/N] "
    read OVERRIDE_DOOM_EMACS

    shopt -s nocasematch
    if [[ $OVERRIDE_DOOM_EMACS =~ (y|yes) ]]; then
        EMACS__INSTALL_DOOM_EMACS_CONFIG=1
    fi
    shopt -u nocasematch
else
    EMACS__INSTALL_DOOM_EMACS_CONFIG=1
fi
if [ ! -z "$EMACS__INSTALL_DOOM_EMACS_CONFIG" ]; then
    rm -rf "$DOOM_EMACS_CONF_DIR"
    ln -rs "$SCRIPTPATH/doom-emacs-config" "$DOOM_EMACS_CONF_DIR"
fi
