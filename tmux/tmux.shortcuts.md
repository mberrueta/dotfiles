# TMUX

?     list commands
:     enter a tmux command
d     detach from session

## Working with Windows

c/&   creates/kill window
,     rename current window
w     list windows
0..1      go to pane

## Working with Panes

|/-       split window vert/horiz
x         kill pane
space     toggle horiz/vert
arrows    go to pane
z         toggle pane zoom
C-Arrows  resize
C-o       rotate panes
{         move the current pane to next
;         go to last pane
tab       next pane

## Copy mode

[       enter copy mode
v       enter selection mode
/       search
v       select
$       end of the line


:source-file ~/.tmux.conf # Reload config
tmux list-keys
