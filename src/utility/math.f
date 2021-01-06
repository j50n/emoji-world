variable (rnd-seed)
utime drop #7 * #1073741825 + (rnd-seed) !

\ https://en.wikipedia.org/wiki/Xorshift
\ Pseudo-random number generator adapted from the 64-bit C shift-register generator.
\ +1 added to seed to prevent 0 loop (without it, 0 in seed will return 0).
: rnd  ( -- n )
    (rnd-seed) @ 1+
    dup 13 lshift xor 
    dup 7 rshift xor 
    dup 17 lshift xor 
    dup (rnd-seed) ! ;

rnd drop

\ Even (lowest bit is clear)?
: even?  { n1 -- f1 }  
    1 n1 and if false else true then ;

\ Odd (lowest bit is set)?
: odd?  ( n1 -- f1 ) 
    even? invert ;