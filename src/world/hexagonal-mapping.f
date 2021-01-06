needs ../utility/math.f

\ One cell on the screen takes up 2 spaces.
\ Odd rows are displaced right one space.
\
\ This is kind of a cool way to be able to lay out a world
\ map, and it lets me stagger the emojis. Square worlds are
\ boring.
\
\ This gives me 6 directions to move (3 axes) :
\   x' -> left/right 
\   y' -> up-left/down-right
\   z' -> up-right/down-left
\ There is no way to move directly up and down. 
\ All up/down motion includes a left or right component.
\
\ This is exactly equivalent to a hexagonal grid.
\
\ The functions here will map the hexagonal grid over
\ a standard 2-D array so the motion appears correct
\ and so you can find adjacent cells. 
\
\  \   /
\   \ /
\ ---*--- x'
\   / \
\  /   \
\ z'   y'
\
\ Positive direction is right for x', down and right for y', 
\ down and left for z'.
\
\ For the math-inclined, draw a clockwise circle starting from
\ the x' axis. This is backwards from Euclidean space because
\ on a terminal, 0,0 is the upper left square.


: go-x'  { x1 y1 n -- x2 y2 } 
    x1 n +
    y1 ;

: go-y'  { x1 y1 n -- x2 y2 }
    x1 n y1 odd? if 1+ then 2/ +
    y1 n + ;

: go-z'  { x1 y1 n -- x2 y2 } 
    x1 n y1 even? if 1+ then 2/ -
    y1 n + ;
