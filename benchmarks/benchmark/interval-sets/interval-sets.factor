! Copyright (C) 2014 John Benediktsson
! See http://factorcode.org/license.txt for BSD license

USING: fry grouping interval-sets kernel math random sequences
sorting ;

in: benchmark.interval-sets

: interval-sets-benchmark ( -- )
    10,000 [ random-32 ] replicate natural-sort
    2 <groups> <interval-set>
    3,000,000 swap '[ random-32 _ in? drop ] times ;

main: interval-sets-benchmark