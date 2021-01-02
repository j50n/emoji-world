needs ./termcommon.f
needs ./termstate.f

\ I am using the 256 color palette. This does not work with the standard Debian terminal, but
\ it works fine with the emulated terminals. Good enough for now. 


\ Reset foreground and background colors to defaults.
: term-colors-reset  ( -- )  
    (reset-colors)
    esc ." [39m" esc ." [49m" ;

\ Set the foreground color.
: .fg  ( n1 -- )
    dup (current-fg) @ = if drop else
        dup (current-fg) !
        esc ." [38;5;" .. [char] m emit
    then ;

\ Set the background color. 
: .bg  ( n1 -- )
    dup (current-bg) @ = if drop else
        dup (current-bg) !
        esc ." [48;5;" .. [char] m emit  
    then ;

\ 8-bit grayscale in 24 steps from black (0) to white (23).
: grayscale24  ( n1 -- n1 )
    dup 0 24 within if
        232 +
    else 
        drop abort" grayscale must be 0..23 inclusive"
    then ;

\ 216 (6x6x6) color palatte. 
: color6  { r g b -- n1 }
    r 0 6 within g 0 6 within b 0 6 within and and if 
        r 36 * g 6 * b + + 16 +
    else
        abort" color must be 0..5 inclusive for R, G, and B."
    then ;

\ For a 216 color palatte, extract r, g, and b to the stack.
: color6-rgb { color -- r g b }
    color 0 0 0 color6 5 5 5 color6 1+ within if
        color 16 - 6 / 6 / 
        color 16 - 6 / 6 mod 
        color 16 - 6 mod
    else
        abort" color must be 16..231 inclusive"
    then ;

0 constant term-black
1 constant term-red
2 constant term-green
3 constant term-yellow
4 constant term-blue
5 constant term-magenta
6 constant term-cyan
7 constant term-white

\ May be used to brighten any of `term-color-*` named colors.
8 constant term-bright

: brighten  ( n1 -- n1 )  term-bright + ;


\ Color convenience words.


: {blk}  ( -- )  term-black .fg ;
: {red}  ( -- )  term-red .fg ;
: {grn}  ( -- )  term-green .fg ;
: {yel}  ( -- )  term-yellow .fg ;
: {blu}  ( -- )  term-blue .fg ;
: {mag}  ( -- )  term-magenta .fg ;
: {cya}  ( -- )  term-cyan .fg ;
: {whi}  ( -- )  term-white .fg ;

: {rst}  ( -- )  term-colors-reset ;
