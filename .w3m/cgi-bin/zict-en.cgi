#!/usr/bin/env sh
echo Content-type: text/plain
zict output "/tmp/zict-en-$QUERY_STRING.html" en "$QUERY_STRING"
echo "w3m-control: LOAD /tmp/zict-en-$QUERY_STRING.html"

# zict output "/tmp/zict-en-$W3M_CURRENT_WORD.html" en "$W3M_CURRENT_WORD"
# echo "w3m-control: LOAD /tmp/zict-en-$W3M_CURRENT_WORD.html"
# echo "LOAD /tmp/zict-en-$W3M_CURRENT_WORD"
