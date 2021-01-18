needs ./place-definitions.f

: demo  ( -- )  
    10 0 do
        pl-mountain1 >places place-draw @ execute
    loop 
    {rst} cr 
    
    space
    10 0 do
        pl-water-wave >places place-draw @ execute
    loop 
    {rst} cr 
    
    10 0 do
        pl-water >places place-draw @ execute
    loop 
    {rst} cr 
    
    space
    10 0 do
        pl-desert >places place-draw @ execute
    loop 
    {rst} cr 
    
    10 0 do
        pl-desert-cactus >places place-draw @ execute
    loop 
    {rst} cr 

    space
    10 0 do
        pl-desert-palm >places place-draw @ execute
    loop 
    {rst} cr 
    ;

demo