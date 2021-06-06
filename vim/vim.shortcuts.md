# VIM

h,j,k,l   left,up,down,right
H,M,L,G   top,middle,bottom,last
#gg       go to line number #
w,e,$     next word (start next,last this),end
b,^       prev word,start  of line
%         move to matching character (),{}, []
^E,^Y     Scroll down,up
^F,^B     Scroll down,up 1 page


## Tab/window
:sp, :vsp Split h,v window
<C-w>j,h  Next window


v,V,C-q   selection: norm, line, block
yy,dd     yank, cut
p,P       paste: after,before
>>,<<     indent (move right,left)
gJ        join lines
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
\"{register}

## Motions

a,i,t,^,$ all,in,til,end-line,start-line
f, F      find forward,find backwards,
numb command motion text_obj
