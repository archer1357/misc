
sleep 5;
t=0.1
t2=0.2
t3=0.5
for i in `seq 1 64`; do 
    sleep $t2;xdotool keydown shift;
    sleep $t3;xdotool click 1; 
    sleep $t2;xdotool keyup shift;
    
    sleep $t2;xdotool mousemove_relative 800 270; 
    sleep $t3;xdotool click 1; 
    sleep $t2;xdotool key 1; 
    sleep $t2;xdotool key 0; 
    sleep $t2;xdotool key 0; 
    sleep $t2;xdotool mousemove_relative -- -100 100; 
    sleep $t3;xdotool click 1; 
    sleep $t3;xdotool mousemove_relative -- -700 -370;
done

mpg123 --loop 1000 f.mp3