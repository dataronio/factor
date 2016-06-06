USING: math kernel debugger namespaces ;
in: benchmark.fib5

symbol: n
: namespace-fib ( m -- n )
    [
        n set
        n get 1 <= [
            1
        ] [
            n get 1 - namespace-fib
            n get 2 - namespace-fib
            +
        ] if
    ] with-scope ;

: fib5-benchmark ( -- ) 30 namespace-fib 1346269 assert= ;

main: fib5-benchmark