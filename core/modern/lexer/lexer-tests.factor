! Copyright (C) 2016 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel modern.lexer sequences tools.test ;
in: modern.lexer.tests

{ T{ slice f 0 8 "dinosaur" } f } [
    "dinosaur" <modern-lexer> lex-til-whitespace [ drop ] 2dip
] unit-test

{ f f } [
    "dinosaur" <modern-lexer>
    [ lex-til-whitespace 3drop ] [ lex-til-whitespace ] bi [ drop ] 2dip
] unit-test