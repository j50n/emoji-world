\ A 2D array where X and Y are circular. 
\ All index values are memory safe.

\ Contains the size information of the world array.
\ The data is allocated directly after the structure,
\ so I can calculate the address easily.
struct 
    cell% field world-width
    cell% field world-height
    cell% field world-cellsize
end-struct world%

\ Allot a new world.  
\
\ Example:
\    create my-world 640 480 cell world-allot
: world-allot  { width height cellsize -- }
    world% %allot { w1 }
    width w1 world-width !
    height w1 world-height !
    cellsize w1 world-cellsize !
    width height * cellsize * allot ;

\ Index into the world array.
: >world { x y w1 -- >s }
    x w1 world-width @ mod
    y w1 world-height @ mod w1 world-width @ * +
    w1 world-cellsize @ *
    world% nip +
    w1 + ;
