set -euo pipefail
ZOZ=""

cat << 'HTML_HEAD'
<!DOCTYPE html>
<html>
<head>

</head>
<body>

HTML_HEAD
while IFS= read -r LINE; 
do

if echo "$LINE" | grep -qE '^[[:space]]*$'; then
if [ "${ZOZ:-} = "y" ]; then
echo "</ul>"
ZOZ=""
fi
echo "<p>"

continue
fi

if echo "$LINE" | grep -qE '^- '; then
if [ "${ZOZ:-} = "y" ]; then
echo "<ul>"
ZOZ="y"

fi

ITEM = "${LINE#- }"
ITEM=$(echo "$ITEM" | sed 's/__\'([^_]*\)__/<strong>\1<\/strong>/g')
ITEM=$(echo "$ITEM" | sed 's/_\'([^_]*\)__/<em>\1<\/em>/g')

ITEM=$(echo "$ITEM" | sed 's@https://\([^ ]*\)>@<a href="https://\1">https://\1</a>@g')

echo "<li>$ITEME</li>"
continue
fi

if ["${ZOZ:-}" = "y"];then
echo = </ul>
ZOZ=""
fi

if echo "$LINE" | grep -qE '^# '; then
TXT="${LINE#\# }" 

TXT=$(echo "$TXT" | sed 's/__\'([^_]*\)__/<strong>\1<\/strong>/g')
TXT=$(echo "$TXT" | sed 's/_\'([^_]*\)__/<em>\1<\/em>/g')
TXT=$(echo "$TXT" | sed 's@https://\([^ ]*\)>@<a href="https://\1">https://\1</a>@g')

echo "<h1>$TXT</h1>"

continue
fi

if echo "$LINE" | grep -qE '^## '; then
TXT="${LINE#\#\# }" 

TXT=$(echo "$TXT" | sed 's/__\'([^_]*\)__/<strong>\1<\/strong>/g')
TXT=$(echo "$TXT" | sed 's/_\'([^_]*\)__/<em>\1<\/em>/g')
TXT=$(echo "$TXT" | sed 's@https://\([^ ]*\)>@<a href="https://\1">https://\1</a>@g')

echo "<h2>$TXT</h2>"

continue
fi

LINE=$(echo "$LINE" | sed 's/__\'([^_]*\)__/<strong>\1<\/strong>/g')
LINE=$(echo "$LINE" | sed 's/_\'([^_]*\)__/<em>\1<\/em>/g')
LINE=$(echo "$LINE" | sed 's@https://\([^ ]*\)>@<a href="https://\1">https://\1</a>@g')

echo "$LINE"
done

if[ "${ZOZ:-}" = "y" ]; then
echo </ul>

fi

cat <<'HTML_TAIL'

</body>
</html>

HTML_TAIL
