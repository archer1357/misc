
sleep 5;

for i in `seq 1 7600`; do 
    sleep 0.15;xdotool click 1;   
done

mpg123 --loop 1000 f.mp3