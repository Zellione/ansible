#!/bin/sh
[ -f "$FUGITIVE.exit" ] && cat "$FUGITIVE.exit" >&2 && exit 1
echo "$1" > "$FUGITIVE.edit"
printf "\033]51;fugitive:edit\007" >&2
while [ -f "$FUGITIVE.edit" -a ! -f "$FUGITIVE.exit" ]; do sleep 0.05 2>/dev/null || sleep 1; done
exit 0
