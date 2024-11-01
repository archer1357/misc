for x in *wmv;do ffmpeg -i "$x" -c:v libx264 -crf 23 -c:a aac -q:a 100 "${x%.*}.mp4";done
