variable (rnd-seed)
utime drop #7 * #1073741825 + (rnd-seed) !

\ https://en.wikipedia.org/wiki/Xorshift
\ Pseudo-random number generator adapted from the 64-bit C shift-register generator.
: rnd  ( -- n )
    (rnd-seed) @
    dup 13 lshift xor 
    dup 7 rshift xor 
    dup 17 lshift xor 
    dup (rnd-seed) ! ;

rnd