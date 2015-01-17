#!/bin/sh

cd $(dirname $0)
CURDIR=`pwd`

HOME_FILES=( .gitconfig .gtkrc-2.0 .xprofile .zshenv .zshrc )
for file in ${HOME_FILES[@]}; do
  if [ ! -e $HOME/$file ]; then
    ln -s $CURDIR/$file $HOME/$file
  fi
done

if [ ! -d $HOME/.config/peco ]; then
  mkdir -p $HOME/.config/peco
fi
if [ ! -e $HOME/.config/peco/config.json ]; then
  ln -s $CURDIR/peco_config.json $HOME/.config/peco/config.json
fi
