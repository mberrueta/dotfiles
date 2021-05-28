#!/usr/bin/env bash

DOTFILES="$(pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

error() {
    printf "${RED}$@${NC}\n"
}

info() {
    printf "${GREEN}$@${NC}\n"
}

warning() {
    printf "${YELLOW}$@${NC}\n"
}


get_linkables() {
    find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'
}


setup_symlinks() {
    info "Creating symlinks"

    for file in $(get_linkables) ; do
        target="$HOME/.$(basename "$file" '.symlink')"
        target="$HOME/.$(basename "$file" '.symlink')"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping."
        else
            info "Creating symlink for $file -> $target"
            ln -s "$file" "$target"
        fi
    done

    info "installing to ~/.config"
    if [ ! -d "$HOME/.config" ]; then
        info "Creating ~/.config"
        mkdir -p "$HOME/.config"
    fi

    config_files=$(find "$DOTFILES/config" -maxdepth 1 2>/dev/null)
    for config in $config_files; do
        target="$HOME/.config/$(basename "$config")"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping."
        else
            info "Creating symlink for $config"
            ln -sv "$config" "$target"
        fi
    done
}

setup_dependencies() {
  info "Creating oh my zsh"
  if [ ! -d "$HOME/.oh-my-zsh/" ]; then
      info "Creating ~/.oh-my-zsh/"
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
      info "Already exists. skipping ~/.oh-my-zsh/"
  fi

  for p in  $(cat ./brew/packages.txt | sed 's/\#.*//')
  do
      echo $p
      brew install $p
  done

  mkdir ~/.vim/tmp 2>/dev/null
}


setup_dependencies
setup_symlinks

