needs ./termcommon.f
needs ./termstate.f

\ Set the visibility of the terminal cursor.
: cursor-visible  ( b1 -- )  esc ." [?25" if [char] h emit else [char] l emit then ;

: term-reset  ( -- )  
    (reset-colors)
    esc ." [0m" ;

: term-bold-on  ( -- )  esc ." [1m" ;

: term-bold-off  ( -- )  esc ." [21m" ;

: term-underline-on  ( -- )  esc ." [4m" ;

: term-underline-off  ( -- )  esc ." [24m" ;

: term-cursor-up  ( n1 -- ) 
    esc ." [" .. ." A" ;

: term-cursor-down  ( n1 -- ) 
    esc ." [" .. ." B" ;

: term-cursor-forward  ( n1 -- ) 
    esc ." [" .. ." C" ;

: term-cursor-back  ( n1 -- ) 
    esc ." [" .. ." D" ;

: term-scroll-up  ( n1 -- ) 
    esc ." [" .. ." S" ;

: term-scroll-down  ( n1 -- ) 
    esc ." [" .. ." T" ;

: term-erase-to-end-of-line ( -- ) 
    esc ." [K" ;

: term-erase-line ( -- ) 
    esc ." [2K" ;