while read -r file; do new_file=$(rev <<< "$file" | sed 's~/~_~' | rev); mv "$file" "$new_file"; done < <(find . -type f)
