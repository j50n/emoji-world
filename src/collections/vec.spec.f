needs ./vec.f

create test1 vec% allot drop
cell 0 test1 vec-init

create test2 vec% allot drop
cell 0 test2 vec-init

: do-tests ( -- )
    assert( test1 ?vec-empty ) 

    1 test1 vec-append !
    assert( test1 vec-last @ 1 = )

     2 test1 vec-append !
     3 test1 vec-append !

     test1 test2 vec-clone

    assert( test2 vec-last @ 3 = )

\     test1 vec-free 
\  test2 vec-free
    ;

do-tests