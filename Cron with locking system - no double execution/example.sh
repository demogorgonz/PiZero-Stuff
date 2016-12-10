#!/bin/bash
LOCKFILE="/tmp/example.lock"
lockfile -r 0 "$LOCKFILE" || exit 0

#do your stuff here

rm -f "$LOCKFILE"
