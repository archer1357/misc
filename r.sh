find ./a -type f -iname '*.*' | while read fn; do 
    name=$(basename "$fn") ; 
    dir=$(dirname "$fn") ; 
    cp "$fn" "./b/$(basename "$dir") $name" ;
done
