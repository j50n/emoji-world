needs ./emojis.f
needs ../term/term.f

struct
    cell% field place-draw
end-struct place%

10 constant #places

create places place% #places * %allot drop

: >places  { index -- 'place }
    index 0 #places within if
        place% nip index * places + 
    else
        1 abort" index out of bounds"  
    then ;

: places-init  { draw-xt index -- }
    draw-xt index >places place-draw ! ;

0 constant pl-mountain1 
: (pl-mountain1-draw)  ( -- )  term-brown6 .bg {whi} em-mountain ;
' (pl-mountain1-draw) pl-mountain1 places-init

1 constant pl-water-wave
: (pl-water-wave-draw)  ( -- )  term-ocean-blue6 .bg {cya} em-water-wave ;
' (pl-water-wave-draw) pl-water-wave places-init

2 constant pl-water
: (pl-water-draw)  ( -- )  term-ocean-blue6 .bg {cya} 2 spaces ;
' (pl-water-draw) pl-water places-init

3 constant pl-desert
: (pl-desert-draw)  ( -- )  term-desert-tan6 .bg {whi} 2 spaces ;
' (pl-desert-draw) pl-desert places-init

4 constant pl-desert-cactus
: (pl-desert-cactus-draw)  ( -- )  term-desert-tan6 .bg {whi} em-cactus ;
' (pl-desert-cactus-draw) pl-desert-cactus places-init

5 constant pl-desert-palm
: (pl-desert-palm-draw)  ( -- )  term-desert-tan6 .bg {whi} em-palm-tree ;
' (pl-desert-palm-draw) pl-desert-palm places-init
