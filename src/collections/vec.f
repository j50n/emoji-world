$CAFEBABE constant vec-type-vec
$DEADBEEF constant vec-type-slice

\ Vec-slice is the base for vec. A slice points into a full vec, 
\ saving the effort of copying the data out. Operations that 
\ would modify the structure of the vec are forbidden. A slice
\ does not own its data.
struct
    \ Type of the vec. Checked at runtime to prevent misuse.
    cell% field vec-type

    \ Count of items currently in the vec.
    cell% field #vec-size

    \ Size in bytes of an item.
    cell% field vec-itemsize

    \ Pointer to the first byte of vec data.
    cell% field 'vec-data
end-struct vec-slice%
    
\ A full vec that owns its data.
vec-slice% 
    \ Capacity of the vec (in items).
    cell% field #vec-capacity
    
    \ XT to free one item. If the operational is successful, wior is 0. 
    \ If the operation fails, wior is a non-zero I/O result code.
    cell% field vec-freeitem ( 'vec -- wior )
end-struct vec%

\ Initialize an empty vec.
: vec-init  { itemsize freeitem 'vec -- } 
    vec-type-vec 'vec vec-type !
    itemsize 'vec vec-itemsize ! 
    freeitem 'vec vec-freeitem ! 
    0 'vec #vec-size !
    0 'vec 'vec-data !
    0 'vec #vec-capacity ! ;

: check-vec-type-valid  { 'vec -- }
    'vec vec-type @ vec-type-vec =
    'vec vec-type @ vec-type-slice =
    or invert
    abort" check-vec-type-valid: invalid vec-type" ;

\ Vec is a vec. May be resized, appended, freed, etc.
: ?vec-is-type-vec  { 'vec -- }
    'vec check-vec-type-valid
    'vec vec-type @ vec-type-vec = ;

\ Vec is a slice. Slice cannot be appended, freed or resized as it is a pointer
\ into another slice or vec.
: ?vec-is-type-slice  { 'vec -- }
    'vec check-vec-type-valid
    'vec vec-type @ vec-type-slice = ;

\ Ensure the vec has at least the capacity requested.
\ Doubles capacity when new memory is needed.
: (vec-ensure-capacity)  { #capacity 'vec -- }
    'vec ?vec-is-type-slice abort" vec-ensure-capacity: can't apply to slice"

    #capacity 0> if
        'vec #vec-capacity @ 0= if
            16 'vec #vec-capacity !
            'vec vec-itemsize @ 'vec #vec-capacity @ *
            allocate abort" vec: error initial allocate"
            'vec 'vec-data ! 
        then

        begin 'vec #vec-capacity @ #capacity < while
            'vec #vec-capacity @ 'vec #vec-capacity +!
            
            'vec 'vec-data @
            'vec vec-itemsize @ 'vec #vec-capacity @ *
            resize abort" vec: error resize"
            
            'vec 'vec-data !
        repeat
    then ;

\ Free the vec by calling `freeitem` on each item, and then freeing the
\ data associated with the vec.
: vec-free  { 'vec -- }
    'vec ?vec-is-type-slice abort" vec-free: can't apply to slice"

    'vec vec-freeitem @ { freeitem }
    freeitem if
        'vec #vec-size @ 0 ?do
            'vec 'vec-data @  'vec vec-itemsize @  i  * + 
            freeitem execute abort" vec-free: error freeing item"
        loop 
    then

    'vec 'vec-data @ free abort" vec-free: error freeing data"

    0 'vec #vec-size !
    0 'vec #vec-capacity !
    0 'vec 'vec-data ! ;

\ Is the vec empty?
: ?vec-empty  { 'vec -- f1 }
    'vec #vec-size @ 0= ;

\ Get the pointer to the last item in the vec. 
\ If empty, abort.
: vec-last  { 'vec -- 'item }
    'vec ?vec-empty if 1 abort" vec.last: vec is empty" then
    'vec 'vec-data @ 'vec #vec-size @ 1- 'vec vec-itemsize @ * + ;

\ Get the pointer to the item at index.
: >vec  { index 'vec -- 'item }
    'vec #vec-size @ index u<= abort" >vec: index out of bounds"
    'vec 'vec-data @ 'vec vec-itemsize @ index * + ;   

\ Append one empty item to the end of the vec and return the
\ pointer to the new item.
: vec-append  { 'vec -- 'item }
    'vec ?vec-is-type-slice abort" vec-append: can't apply to slice"

    'vec #vec-size @ 1+ 'vec (vec-ensure-capacity) 
    1 'vec #vec-size +!
    'vec vec-last ;

\ Clone a vec.
\ vec-from may be a slice. vec-from must be a vec.
\ Itemsize of vec-to will be set to that of vec-from.
\ xt freeitem of vec-to will be set to that of vec-from.
\ Note that this could break any slices that reference vec-to.
: vec-clone  { 'vec-from 'vec-to -- }
    'vec-from check-vec-type-valid
    'vec-to ?vec-is-type-slice abort" vec-free: vec-to can't be a slice"

    'vec-from vec-itemsize @ 'vec-to vec-itemsize !
    'vec-from #vec-size @ 'vec-to #vec-size !
    'vec-from #vec-size @ 'vec-to (vec-ensure-capacity)

    'vec-from vec-freeitem @ 'vec-to vec-freeitem !
     
    'vec-from 'vec-data @
    'vec-to 'vec-data @
    'vec-from #vec-size @ 'vec-from vec-itemsize @ * 
    move ;