#!/bin/sh

case "$1" in
    --clean)
        trash-empty -f
        ;&
    *)
        du --summarize -h $TRASH
        ;;
esac
