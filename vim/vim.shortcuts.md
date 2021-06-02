# VIM

h,j,k,l   left,up,down,right
H,M,L,G   top,middle,bottom,last
#gg       go to line number #
w,e,$     next word (start next,last this),end 
b,^       prev word,start  of line
%         move to matching character (),{}, []
^E,^Y     Scroll down,up
^F,^B     Scroll down,up 1 page
SHIFT DOWN  previous possition

>>,<<     indent (move right,left) 
yy        yank (copy)
dd        cut
p         put (paste)
gJ        join lines
v,q       selection, block
V         select line
~         switch case
C-j,C-k   move line down,up 

/pattern  search
n,N       repeat search in same/opposite dir
:%s/old/new/g   replace all old with new
:g/regex/d      delete all lines with regex
u/C-r           undo/redo
.               repeat last command

## Text objects

w,s,p   word, sentence, paragraf
t,_     tags, line

## Motions

a,i,t     all,in,til
f, F      find forward,find backwards,
numb command motion text_obj 
