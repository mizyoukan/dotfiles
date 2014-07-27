#!/bin/sh

usermodmap=$HOME/.xmodmap

if [ -f $usermodmap ]; then
	xmodmap $usermodmap
fi

xset r rate 250 25

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &

urxvtd --quiet --opendisplay --fork
urxvtc &

exec xmonad
