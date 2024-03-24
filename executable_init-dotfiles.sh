#!/usr/bin/env bash

help() {
  echo 'Usage : ./init-dotfiles.sh [-h|--help]'
}

# Parse options
OPTIONS=$(getopt -o h --long help -n 'init-dotfiles.sh' -- "$@")
if [ $? -ne 0 ]; then
  help
  exit 1
fi
eval set -- "$OPTIONS"

# Extract options and their arguments into variables.
while true; do
  case "$1" in
  -h | --help)
    help
    exit 0
    ;;
  --)
    shift
    break
    ;;
  *)
    break
    ;;
  esac
done

GIT_USER=$1

sudo apt-get install make build-essential git libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 && . "$HOME/.asdf/asdf.sh"
asdf plugin-add chezmoi && asdf install chezmoi latest
asdf plugin-add nodejs && asdf install nodejs latest
asdf plugin-add pnpm && asdf install pnpm latest
asdf plugin-add python && asdf install python latest

curl -sS https://starship.rs/install.sh | sh

chsh -s /usr/bin/fish

chezmoi init --apply $GIT_USER
