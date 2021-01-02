needs ./termcommon.f
needs ./termstate.f



\ Reset foreground and background colors to defaults.
: term-colors-reset  ( -- )  
    (reset-colors)
    esc ." [39m" esc ." [49m" ;

: .fg  ( n1 -- )
    dup (current-fg) @ = if drop else
        dup (current-fg) !
        esc ." [38;5;" .. [char] m emit
    then ;

: .bg  ( n1 -- )
    dup (current-bg) @ = if drop else
        dup (current-bg) !
        esc ." [48;5;" .. [char] m emit  
    then ;

\ 8-bit grayscale in 24 steps from black (0) to white (23).
: grayscale  ( n1 -- n1 )
    dup 0 24 within if
        232 +
    else 
        drop abort" grayscale must be 0..23 inclusive"
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
