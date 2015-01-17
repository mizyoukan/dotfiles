#!/bin/sh

cd $(dirname $0)
CURDIR=`pwd`

HOME_FILES=( .gitconfig .gtkrc-2.0 .xprofile .zshenv .zshrc )
for file in ${HOME_FILES[@]}; do
  if [ ! -e $HOME/$file ]; then
    ln -s $CURDIR/$file $HOME/$file
  fi
done
