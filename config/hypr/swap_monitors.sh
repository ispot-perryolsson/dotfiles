#!/bin/bash

MON1="DP-1"
MON2="DP-2"

WS1=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$MON1\") | .activeWorkspace.name")
WS2=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$MON2\") | .activeWorkspace.name")

WINS_MON1=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name==\"$WS1\") | .address")
WINS_MON2=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name==\"$WS2\") | .address")

for win in $WINS_MON1; do
  hyprctl dispatch movetoworkspace "$WS2,address:$win"
done

for win in $WINS_MON2; do
  hyprctl dispatch movetoworkspace "$WS1,address:$win"
done
