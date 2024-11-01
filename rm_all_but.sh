find . -type d -iname "*" | while read -r i ; do
    echo "=== $i"
    find "$i" -maxdepth 1 -type f -iname "*.txt" | tail -n +2  | while read -r j ; do
        echo "$j"
    done
done
