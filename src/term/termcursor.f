needs ./termcommon.f
needs ./termstate.f

\ Set the visibility of the terminal cursor.
: cursor-visible  ( b1 -- )  esc ." [?25" if 'h emit else 'l emit then ;

: term-reset  ( -- )  
    (reset-colors)
    esc ." [0m" ;

: {r}  ( -- ) term-reset ;

: term-bold-on  ( -- )  esc ." [1m" ;

: term-bold-off  ( -- )  esc ." [21m" ;

: {b}   ( -- )  term-bold-on ;
: {/b}  ( -- )  term-bold-off ;

: term-underline-on  ( -- )  esc ." [4m" ;

: term-underline-off  ( -- )  esc ." [24m" ;

: {u}   ( -- )  term-underline-on ;
: {/u}  ( -- )  term-underline-off ;

: term-cursor-up  ( n1 -- ) 
    esc ." [" .. 'A emit ;

: term-cursor-down  ( n1 -- ) 
    esc ." [" .. 'B emit ;

: term-cursor-forward  ( n1 -- ) 
    esc ." [" .. 'C emit ;

: term-cursor-back  ( n1 -- ) 
    esc ." [" .. 'D emit ;

: term-scroll-up  ( n1 -- ) 
    esc ." [" .. 'S emit ;

: term-scroll-down  ( n1 -- ) 
    esc ." [" .. 'T emit ;

: term-erase-to-end-of-line ( -- ) 
    esc ." [K" ;

: term-erase-line ( -- ) 
    esc ." [2K" ;