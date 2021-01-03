needs ./term/term.f
needs ./world/world.f
needs ./utility/math.f

\ Make even.
: evenify ( n1 -- n1even ) $FFFFFFFFFFFFFFFE and ;

\ Do nothing until the escape key is pressed.
: wait-for-escape ( -- )
    begin 
        key
    #27 = until ;

: pick-a-spot ( -- )
    rnd term-width mod evenify 
    rnd term-height mod 
    at-xy ;

: scatter { xt n1 -- } 
     n1 0 do
          pick-a-spot
          xt execute
     loop ;

false cursor-visible
0 0 0 color6 .bg
page
' em-star 100 scatter
' em-glowing-star 20 scatter
' em-ringed-planet 3 scatter
' em-full-moon-face 1 scatter
wait-for-escape
0 0 at-xy
term-reset
true cursor-visible
bye