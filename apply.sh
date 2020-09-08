#/usr/bin/env bash

DOTFILES=\.*
SCRIPTS_DIR="$HOME/.scripts"
ANTIGEN_LOC="$HOME/.zsh-scripts/antigen.zsh"
ASDF_LOC="$HOME/.asdf"

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
