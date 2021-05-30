# VIM

h,j,k,l   left,up,down,right
H,M,L,G   top,middle,bottom,last
#gg       go to line number #
w,e,$     next word (start next,last this),end of line
b,^       prev word,start  of line
%         move to matching character (),{}, []
^E,^Y     Scroll down,up
^F,^B     Scroll down,up 1 page

>>,<<     indent (move right,left) line one shiftwidth
yy        yank (copy)
dd        cut
p         put (paste)
gJ        join lines
~         switch case

/pattern  search
n,N       repeat search in same/opposite direction
:%s/old/new/g     replace all old with new throughout file

u/C-r        undo/redo
.        repeat last command

## Text objects

w,s,p,t        word, sentence, paragraf, tags

## Motions

a,i,t,f,F        all,in,til,find forward,find backwards,
number_lines command text_object / motion
