#!/bin/bash

IFS='' read -r -d '' code << "EOF"
import sys

for line in sys.stdin:
    parts = line.split(" ", 1)
    code = "".join(["\\U" + x.zfill(8) for x in parts[0].split("-")])
    code = code.encode("utf-8").decode("unicode-escape")
    print(code, parts[1], end="")
EOF

jq -r '. | .[] | [.code_points.fully_qualified] + .ascii + [.shortname[1:-1]] + [.shortname_alternatives[1:-1]] + .keywords[:-1] | join(" ")' ~/emoji-assets/emoji.json |
    tr -s " " |
    python -c "$code" > "${XDG_CACHE_HOME:-$HOME/.cache}/emoji.data"
