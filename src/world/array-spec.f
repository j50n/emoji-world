needs ./array.f

." TESTS FOR ARRAY.F (WORLD ARRAYS)" cr

create w1 5 3 cell world-allot

: load-world  ( -- )
    3 0 do 
        5 0 do
            i 1+ j 1+  10 * +
            i j w1 >world !
        loop
    loop 
    
    w1 3 15 + cells dump ;

: print-world  ( -- )
    4 -1 do 
        2 spaces
        6 -1 do
            i j w1 >world @ . space
        loop
        cr
    loop ;

: check-values  ( -- )
    assert( 0 0 w1 >world @ 11 = ) 
    assert( -1 -1 w1 >world @ 35 = )

    assert( 4 2 w1 >world @ 35 = )
    assert( 5 3 w1 >world @ 11 = ) 
    
    assert( 0 2 w1 >world @ 31 = )
    assert( 4 0 w1 >world @ 15 = ) 
    
    cr ." Dang, world-arrays actually works!" cr ;

load-world
print-world
check-values


