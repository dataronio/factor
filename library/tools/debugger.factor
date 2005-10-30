! Copyright (C) 2004, 2005 Slava Pestov.
! See http://factor.sf.net/license.txt for BSD license.
IN: errors
USING: generic inspector kernel kernel-internals lists math
namespaces parser prettyprint sequences io sequences-internals
strings vectors words ;

SYMBOL: error
SYMBOL: error-continuation

: expired-error. ( obj -- )
    "Object did not survive image save/load: " write . ;

: undefined-word-error. ( obj -- )
    "Undefined word: " write . ;

: io-error. ( error -- )
    "I/O error: " write print ;

: type-check-error. ( list -- )
    "Type check error" print
    uncons car dup "Object: " write short.
    "Object type: " write class .
    "Expected type: " write type>class . ;

: float-format-error. ( list -- )
    "Invalid floating point literal format: " write . ;

: signal-error. ( obj -- )
    "Operating system signal " write . ;

: negative-array-size-error. ( obj -- )
    "Cannot allocate array with negative size " write . ;

: c-string-error. ( obj -- )
    "Cannot convert to C string: " write . ;

: ffi-error. ( obj -- )
    "FFI: " write print ;

: heap-scan-error. ( obj -- )
    "Cannot do next-object outside begin/end-scan" print drop ;

: undefined-symbol-error. ( obj -- )
    "The image refers to a library or symbol that was not found"
    " at load time" append print drop ;

: user-interrupt. ( obj -- )
    "User interrupt" print drop ;

PREDICATE: cons kernel-error ( obj -- ? )
    dup first kernel-error = swap second 0 11 between? and ;

M: kernel-error error. ( error -- )
    #! Kernel errors are indexed by integers.
    cdr uncons car swap {
        [ expired-error. ]
        [ io-error. ]
        [ undefined-word-error. ]
        [ type-check-error. ]
        [ float-format-error. ]
        [ signal-error. ]
        [ negative-array-size-error. ]
        [ c-string-error. ]
        [ ffi-error. ]
        [ heap-scan-error. ]
        [ undefined-symbol-error. ]
        [ user-interrupt. ]
    } dispatch ;

M: no-method error. ( error -- )
    "No suitable method." print
    "Generic word: " write dup no-method-generic .
    "Methods: " write dup no-method-generic order .
    "Object: " write dup no-method-object short.
    "Object class: " write no-method-object class short. ;

M: no-math-method error. ( error -- )
    "No suitable arithmetic method." print
    "Generic word: " write dup no-math-method-generic .
    "Left operand: " write dup no-math-method-left short.
    "Right operand: " write no-math-method-right short. ;

: parse-dump ( error -- )
    "Parsing " write
    dup parse-error-file [ "<interactive>" ] unless* write
    ":" write
    dup parse-error-line [ 1 ] unless* number>string print
    
    dup parse-error-text dup string? [ print ] [ drop ] if
    
    parse-error-col [ 0 ] unless* CHAR: \s fill write "^" print ;

M: parse-error error. ( error -- )
    dup parse-dump  delegate error. ;

M: bounds-error error. ( error -- )
    "Sequence index out of bounds" print
    "Sequence: " write dup bounds-error-seq short.
    "Minimum: 0" print
    "Maximum: " write dup bounds-error-seq length .
    "Requested: " write bounds-error-index . ;

M: string error. ( error -- ) print ;

M: object error. ( error -- ) . ;

: :s ( -- ) error-continuation get continuation-data stack. ;

: :r ( -- ) error-continuation get continuation-call stack. ;

: :get ( var -- value )
    error-continuation get continuation-name (get) ;

: debug-help ( -- )
    ":s :r show stacks at time of error." print
    ":get ( var -- value ) inspects the error namestack." print ;

: flush-error-handler ( -- )
    #! Last resort.
    [ "Error in default error handler!" print ] when ;

: print-error ( error -- )
    #! Print the error.
    [ dup error. ] catch nip flush-error-handler ;

: try ( quot -- )
    #! Execute a quotation, and if it throws an error, print it
    #! and return to the caller.
    [ print-error debug-help ] recover ;

: save-error ( error continuation -- )
    global [ error-continuation set error set ] bind ;

: error-handler ( error -- )
    dup continuation save-error rethrow ;

: init-error-handler ( -- )
    ( kernel calls on error )
    [ error-handler ] 5 setenv
    kernel-error 12 setenv ;
