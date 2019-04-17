; vim: set et ts=8 sw=8 sts=8 fdm=marker syntax=64tass:

; The code here probably requires sacrificing a small animal


        bitmap = $2000
.if KOALA_RAW
        vidram = $3f40
        colram = $4328
.else
        vidram = $0c00
        colram = $1000
.endif

        * = $0801

        .word (+), 2019
        .null $9e, format("%d", init)
+       .word 0

init
        lda #$3b
        sta $d011
        lda #$03
        sta $dd00
.if KOALA_RAW
        lda #$18
.else
        lda #$38
.endif
        sta $d018
        lda #$18
        sta $d016
        ldx #0
-
  .for i = 0, i < 4, i += 1
        lda colram + i  * 256,x
        sta $d800 + i * 256,x

    .if KOALA_RAW
       lda vidram + i * 256,x
        sta $0400 + i * 256,x
     .endif

  .next
        inx
        bne -


.if KOALA_RAW
        lda bitmap + 10000
.else
        lda #KOALA_BGCOLOR
.endif
        sta $d020
        sta $d021

        jmp *


        * = bitmap


.if !KOALA_RAW
.binary KOALA_BITMAP, 2

        .fill bitmap + $1f40 - *, 0

        * = vidram
.binary KOALA_VIDRAM, 2

        .fill vidram + $03e8 - *, 0

        * = colram
.binary KOALA_COLRAM, 2

        .fill colram + $03e8 - *, 0

.else

.binary KOALA_RAW,2

.endif
