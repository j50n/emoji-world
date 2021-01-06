needs ./hexagonal-mapping.f
needs ../term/term.f

cr 
{b} ." TESTS FOR HEXAGONAL TO EUCLIDEAN MAPPING FUNCTIONS" {r} cr

: should-be2 { x1 y1 x2 y2 -- f1 }
    x1 x2 = 
    y1 y2 =
    and ;

\ x' axis just moves 1 for 1 along the x axis.
: test-x' ( -- )
    ." TEST X' AXIS" cr
    assert( 1 1 0 go-x' 1 1 should-be2 )

    assert( 1 1 1 go-x' 2 1 should-be2 )
    assert( 0 2 -1 go-x' -1 2 should-be2 ) ;

\ y' axis moves down to the right for the positive direction. 
\ x movement is staggered.
: test-y' ( -- )
    ." TEST Y' AXIS" cr

    ( y is even )
    assert( 1 0 0 go-y' 1 0 should-be2 )

    assert( 1 0 1 go-y' 1 1 should-be2 )
    assert( 1 0 2 go-y' 2 2 should-be2 )
    assert( 1 0 3 go-y' 2 3 should-be2 )
    assert( 1 0 -1 go-y' 0 -1 should-be2 )
    assert( 1 0 -2 go-y' 0 -2 should-be2 )

    ( y is odd )
    assert( 0 1 0 go-y' 0 1 should-be2 )

    assert( 0 1 1 go-y' 1 2 should-be2 )
    assert( 0 1 2 go-y' 1 3 should-be2 )
    assert( 0 1 3 go-y' 2 4 should-be2 )
    assert( 0 1 -1 go-y' 0 0 should-be2 )
    assert( 0 1 -2 go-y' -1 -1 should-be2 )
    assert( 0 1 -3 go-y' -1 -2 should-be2 ) ;

: test-z' ( -- )
    ." TEST Z' AXIS" cr

     ( y is even )
    assert( 2 0 0 go-z' 2 0 should-be2 )

    assert( 2 0 1 go-z' 1 1 should-be2 )
    assert( 2 0 2 go-z' 1 2 should-be2 )
    assert( 2 0 3 go-z' 0 3 should-be2 )
    assert( 2 4 -1 go-z' 2 3 should-be2 )
    assert( 2 4 -2 go-z' 3 2 should-be2 )
    assert( 2 4 -3 go-z' 3 1 should-be2 )

    ( y is odd )
    assert( 3 1 0 go-z' 3 1 should-be2 )

    assert( 3 1 1 go-z' 3 2 should-be2 )
    assert( 3 1 2 go-z' 2 3 should-be2 )
    assert( 3 1 3 go-z' 2 4 should-be2 )
    assert( 1 3 -1 go-z' 2 2 should-be2 )
    assert( 1 3 -2 go-z' 2 1 should-be2 )
    assert( 1 3 -3 go-z' 3 0 should-be2 ) ;

test-x'
test-y'
test-z'