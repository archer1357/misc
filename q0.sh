find "$1" -type f -iname '*.*' | while read fn; do
    name=$(basename "$fn") ;
    dir=$(dirname "$fn") ;
    dirbase=$(basename "$dir")
    paramdirbase=$(basename "$1")
    dir2="./${paramdirbase}_sm/$dirbase"
    #echo "'$fn' './b/$(basename "$dir") $name'" ;
    mkdir -p "$dir2"
    echo "'$fn' => '$dir2/$name'"
    convert "$fn" -quality 50 "$dir2/$name"
    # convert "$fn" -quality 75 -resize 50% "$dir2/$name" && rm "$fn"
    # break
done

#find . -iname "*.jpg" -exec convert {} -resize 50% -quality 75 ../out/{} \;