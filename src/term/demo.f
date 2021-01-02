needs ./term.f

\ Demonstrating Terminal Stuff (Visual Tests)

." CURSOR VISIBILITY" cr 
."     HIDDEN" 
    false cursor-visible 
    2000 ms 
    cr
."     SHOWN"
    true cursor-visible
    2000 ms
    cr

." GRAYSCALE BACKGROUND, BLUE LETTERS" cr ."     "
: demo-grayscale  ( -- )
    term-blue .fg
    24 0 do 
        i grayscale .bg 
        space 
        [char] A i + emit  
        space 
        100 ms
    loop ;
demo-grayscale
term-colors-reset
cr

." DONE" cr