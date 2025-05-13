#!/bin/env bash

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
  hyprctl keyword general:layout dwindle
  hyprctl keyword unbind SUPER,J
  hyprctl keyword unbind SUPER,K
  hyprctl keyword unbind SUPERSHIFT,Return
  hyprctl keyword unbind SUPERSHIFT,period
  hyprctl keyword unbind SUPERSHIFT,comma
  hyprctl keyword unbind SUPERCTRL,Return
  hyprctl keyword bind SUPER,J,movefocus,d
  hyprctl keyword bind SUPER,K,movefocus,u
  hyprctl keyword bind SUPER,O,togglesplit
  hyprctl keyword bind SUPER,P,pseudo
  hyprctl keyword bind SUPERSHIFT,P,exec,hyprctl dispatch workspaceopt allpseudo
  notify-send "Layout" "Dwindle"
  ;;
"dwindle")
  hyprctl keyword general:layout master
  hyprctl keyword unbind SUPER,J
  hyprctl keyword unbind SUPER,K
  hyprctl keyword unbind SUPER,O
  hyprctl keyword unbind SUPER,P
  hyprctl keyword unbind SUPERSHIFT,P
  hyprctl keyword bind SUPER,J,layoutmsg,cyclenext
  hyprctl keyword bind SUPER,K,layoutmsg,cycleprev
  hyprctl keyword bind SUPERSHIFT,Return,layoutmsg,swapwithmaster
  hyprctl keyword bind SUPERSHIFT,period,layoutmsg,orientationnext
  hyprctl keyword bind SUPERSHIFT,comma,layoutmsg,orientationprev
  hyprctl keyword bind SUPERCTRL,Return,layoutmsg,focusmaster
  notify-send "Layout" "Master"
  ;;
*) ;;

esac

