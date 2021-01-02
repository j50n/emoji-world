needs ./term.f

\ Demonstrating Terminal Stuff (Visual Tests)

." TEXT COLORS" cr
."     " {blk} ." BLACK" {red} ." RED" {grn} ." GREEN" {yel} ." YELLOW" 
         {blu} ." BLUE" {mag} ." MAGENTA" {cya} ." CYAN" {whi} ." WHITE" 
         {rst} ." default" 2cr

." CURSOR VISIBILITY" cr 
."     HIDDEN" 
    false cursor-visible 
    2000 ms 
    cr
."     SHOWN"
    true cursor-visible
    2000 ms
    2cr

: rev3  ( n1 n2 n3 -- n3 n2 n1 ) -rot swap ;

." COLOR BACKGROUND" 
: demo-colors  ( -- )
    {blk}
    5 5 5 color6 1+ 0 0 0 color6 do
        i 16 - 36 mod 0 = if {rst} cr 4 spaces then
        i .bg
        space
        i color6-rgb rev3 .. .. ..
        space 
        50 ms
    loop 
    {rst} ;

demo-colors
2cr

." GRAYSCALE BACKGROUND, BLUE LETTERS" cr ."     "
: demo-grayscale  ( -- )
    term-blue .fg
    24 0 do 
        i grayscale24 .bg 
        space 
        [char] A i + emit  
        space 
        100 ms
    loop ;
demo-grayscale
term-colors-reset
2cr

." DONE" cr