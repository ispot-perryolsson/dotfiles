#!/bin/bash

# Specify the source workspace (e.g., 2)
SOURCE_WORKSPACE="$1"

# Get the current workspace ID
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

is_move_back=1
if [ "$SOURCE_WORKSPACE" == "" ]; then
    SOURCE_WORKSPACE=$CURRENT_WORKSPACE
    CURRENT_WORKSPACE=9
    is_move_back=0
fi

# Check if current workspace was retrieved
if [ -z "$CURRENT_WORKSPACE" ]; then
    exit 1
fi

# Get all windows on the source workspace
WINDOWS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $SOURCE_WORKSPACE) | .address")

# Check if any windows were found
if [ -z "$WINDOWS" ]; then
  exit 0
fi

# Move each window to the current workspace
index=0
for WINDOW in $WINDOWS; do
    if [[ "$index" -eq 0 ]]; then
        hyprctl dispatch movetoworkspacesilent "$CURRENT_WORKSPACE,address:$WINDOW" > /dev/null
    fi
    ((index++))
done

if [ "$is_move_back" -eq "1" ]; then
    hyprctl dispatch focuswindow address:$(echo $WINDOWS | sed 's/ .*//g') > /dev/null
fi

