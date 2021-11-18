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

    # mkdir $HOME/.config/nvim || true
    # mv $HOME/.nvim $HOME/.config/nvim/init.vim


    gem install solargraph
    # nvim +PlugInstall +UpdateRemotePlugins +qa
}

setup_dependencies() {
  brew install --cask iterm2

  # ohmyzsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

  brew install python3
  pip3 install powerline-status
  pip3 show powerline-status

  cp -r /opt/homebrew/lib/python3.9/site-packages/powerline/config_files/ ~/.config/powerline/
  git clone git@github.com:powerline/fonts.git ~/.config
  ~/.config/fonts/install.sh

  p10k configure


  # RVM
  curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
  curl -sSL https://get.rvm.io | bash -s stable --rails


  info "Creating oh my zsh"
  if [ ! -d "$HOME/.oh-my-zsh/" ]; then
      info "Creating ~/.oh-my-zsh/"
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
      info "Already exists. skipping ~/.oh-my-zsh/"
  fi

#   info "Creating tmux"
#   if [ ! -d "$HOME/.tmux/" ]; then
#       info "Creating ~/.tmux/"
#     #   git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
#       git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#     #   ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
#     #   ln -sf "$HOME/.tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
#   else
#       info "Already exists. skipping ~/.oh-my-tmux/"
#   fi

  for p in  $(cat ./brew/packages.txt | sed 's/\#.*//')
  do
      echo $p
      brew install $p
  done

  mkdir ~/.vim/tmp 2>/dev/null

#   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


  # open https://docs.docker.com/docker-for-mac/install/
  # open https://docs.docker.com/docker-for-mac/apple-silicon/
  # open https://rectangleapp.com
  open https://apps.apple.com/es/app/amphetamine/id937984704?mt=12
  open https://monosnap.com/pay

  brew install --cask rectangle
  brew install --cask slack
  brew install --cask whatsapp
  brew install --cask docker
  brew install --cask dbeaver-community
  brew install --cask vlc

  npm install --global git-open

  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

}

update_all() {
    curr=$(pwd)
    brew && brew upgrade -Y
    cd "$HOME/.tmux"
    git checkout master
    git pull --all
}

background() {

DOTFILES="$(pwd)"
export LC_CTYPE="en_US.UTF-8"
text=$(cat $DOTFILES/zsh/zsh.shortcuts.md)
convert -font helvetica -fill white -pointsize 14  -draw "text 100, 50 '$text'"  ./backgrounds/maniac_mansion.jpg /tmp/t1.jpg
# text=$(cat $DOTFILES/tmux/tmux.shortcuts.md)
# convert -font helvetica -fill white -pointsize 14  -draw "text 50, 50 '$text'"  ./backgrounds/maniac_mansion.jpg /tmp/t1.jpg
# text=$(cat $DOTFILES/vim/vim.shortcuts.md)
# convert -font helvetica -fill white -pointsize 14  -draw "text 450, 50 '$text'"  /tmp/t1.jpg /tmp/t1.jpg
# text=$(cat $DOTFILES/vim/vimplugins.shortcuts.md)
# convert -font helvetica -fill white -pointsize 14  -draw "text 750, 50 '$text'"  /tmp/t1.jpg /tmp/t1.jpg
text=$(cat $DOTFILES/zsh/mac.shortcuts.md)
convert -font helvetica -fill white -pointsize 14  -draw "text 470, 50 '$text'"  /tmp/t1.jpg /tmp/t1.jpg
rm ~/Pictures/t1.jpg 2> /dev/null
cp /tmp/t1.jpg ~/Pictures/
#open ~/Pictures/t1.jpg

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/Pictures/t1.jpg"'
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/t1.jpg"'

}


if [ $1 = "fresh" ]; then
  setup_dependencies
fi

if [ $1 = "update" ]; then
  update_all
fi

setup_symlinks
# background
