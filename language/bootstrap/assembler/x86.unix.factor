! Copyright (C) 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: cpu.x86.assembler cpu.x86.assembler.operands kernel
layouts ;
in: bootstrap.x86

defer: stack-reg

: jit-save-tib ( -- ) ;
: jit-restore-tib ( -- ) ;
: jit-update-tib ( ctx-reg -- ) drop ;
: jit-install-seh ( -- ) stack-reg bootstrap-cell ADD ;
: jit-update-seh ( ctx-reg -- ) drop ;