#!/bin/bash
script_dir="$(dirname "$(readlink -f "$0")")"
$script_dir/../copy_file.sh $1 .config/tmux/tmux.conf
