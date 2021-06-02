# TMUX

?     list commands
:     enter a tmux command
d     detach from session

## Working with Windows

c/&   creates/kill window
,     rename current window
w     list windows
## Working with Panes

q         show pane numbers
|/-       split window vert/horiz
x         kill pane
0..1      go to pane
space     toggle horiz/vert
arrows    go to pane
z         toggle pane zoom
C-Arrows  resize
C-o       rotate panes

## Copy mode

[       enter copy mode
v       enter selection mode
/       search
v       select
$       end of the line


:source-file ~/.tmux.conf # Reload config
tmux list-keys