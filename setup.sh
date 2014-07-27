#!/bin/sh

cd $(dirname $0)
CURDIR=`pwd`

HOME_FILES=( .dmrc .gitconfig .gtkrc-2.0 .Xdefaults .xinitrc .xmobarrc .zshenv .zshrc )
for file in ${HOME_FILES[@]}; do
  if [ ! -e $HOME/$file ]; then
    ln -s $CURDIR/$file $HOME/$file
  fi
done

if [ ! -e $HOME/.xprofile ]; then
  ln -s $CURDIR/.xinitrc $HOME/.xprofile
fi

if [ ! -r $HOME/.xmonad/xmonad.hs ]; then
  mkdir -p $HOME/.xmonad
  ln -s $CURDIR/.xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
fi
