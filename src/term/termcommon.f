27 constant escape-key

\ Display the number without a trailing space.
: ..  ( n1 -- )          s>d 0 d.r ;

\ Emit the escape character.
: esc  ( -- )             escape-key emit ;

\ Height of the terminal in characters.
: term-height  ( -- n1 )  form drop ;

\ Width of the terminal in characters.
: term-width  ( -- n1 )   form nip ;