find . -type d -iname "*|*" -exec rename "s/[|]/_/" "{}"  \;
find . -type d -iname "*:*" -exec rename "s/:/_/" "{}"  \;