#!/usr/bin/env bash
PROJECT="$1"
FILE="$2"
LINE="${3:-1}"
COL="${4:-1}"

if [ -S "$PROJECT/server.pipe" ]; then
    nvim --server "$PROJECT/server.pipe" --remote-send "<C-\><C-N>:e $FILE<CR>:${LINE}<CR>"
else
    nvim --server ./server.pipe --remote-send "<C-\><C-N>:e $FILE<CR>:${LINE}<CR>" 2>/dev/null
fi

tmux select-window -t :nvim 2>/dev/null || tmux select-window -t :1 2>/dev/null

osascript -e 'tell application "kitty" to activate' 2>/dev/null || \
osascript -e 'tell application "Terminal" to activate' 2>/dev/null
