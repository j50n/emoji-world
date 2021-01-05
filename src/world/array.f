\ A 2D array where X and Y are circular. 
\ All index values are memory safe.

struct 
    cell% field world-width
    cell% field world-height
    cell% field world-cellsize
end-struct world%

\ Allot a new world.  
\
\ Example:
\    create my-world 1000 1000 cell world-allot
: world-allot  { width height cellsize -- }
    here
    world% %allot drop
    dup width swap world-width !
    dup height swap world-height !
    dup cellsize swap world-cellsize !
    drop
    width height * cellsize * allot ;

\ Index into the world array.
: >world { x y w -- >s }
    x w world-width @ mod
    y w world-height @ mod w world-width @ * +
    w world-cellsize @ *
    world% nip +
    w + ;
