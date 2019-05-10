#!/bin/bash

# Usage: koala.sh bitmap vidram colram [bgcolor]

PRG=koala-show.prg


usage() {
    echo "Usage: `basename "$0"` <bitmap> <vidram> <colram> [background-color]"
    echo "   or: `basename "$0"` <koala-file>"
}


if [ $# -lt 3 -a $# -ne 1 ]; then
    usage
    exit 1
fi

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    usage
    exit 0
fi


if [ -z "$4" ]; then
    BGCOLOR="0"
else
    BGCOLOR="$4"
fi


cp -f `dirname "$0"`/koala.s .


if [ $# -ge 3 ]; then

    64tass --ascii --case-sensitive --m6502 \
        -D KOALA_BITMAP=\"$1\" \
        -D KOALA_VIDRAM=\"$2\" \
        -D KOALA_COLRAM=\"$3\" \
        -D KOALA_BGCOLOR=$BGCOLOR \
        -D KOALA_RAW=0 \
        koala.s \
        -o $PRG
elif [ $# -eq 1 ]; then
    64tass --ascii --case-sensitive --m6502 \
        -D KOALA_RAW=\"$1\" \
        koala.s \
        -o $PRG
fi


# run binary on sucessful assemble
if [ "$?" -eq "0" ]; then
    x64sc -autostartprgmode 1 $PRG
fi
