#!/usr/bin/env bash

# NOTE: LIB/SYMLINKG
#
# TODO: if regular file > prompt user overwrite??? yes/no

function dotfiles_location() {
    echo "$HOME/.dotfiles"
}

function dot_symlink() {
    local file=$1
    local link_destination=$2
    local force=$3
    local dotfiles_full_path="$(dotfiles_location)/$file"

    if [ ! -e "$link_destination" ]; then
        dotsay "@b@green[[ Symlink: $file -> $link_destination ]]"
        mkdir -p "$(dirname "$link_destination")"
        ln -s "$dotfiles_full_path" "$link_destination"
    elif [[ -L $link_destination ]]; then
        dotsay "@b@blue[[ Force re-link: $file -> $link_destination ]]"
        rm -rf $link_destination # be carefull;
        ln -s "$dotfiles_full_path" "$link_destination"
    else
        dotsay "@b@red[[ Cannot link: \`$link_destination\` is a regular file/dir and needs to be removed manually first... ]]"
    fi
}
