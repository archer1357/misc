sleep 7; 
for k in `seq 1 5`; do 
    for j in `seq 1 8`; do 
        for i in `seq 1 1`; do 
            #sleep 0.2;xdotool click 3; 
            sleep 0.4;xdotool mousemove_relative 150 550; 
            #sleep 0.2;xdotool click --repeat 2 1
            #sleep 0.2;xdotool key --repeat 2 f; 
            sleep 0.2;xdotool mousemove_relative -- -150 -550;  
        done
        sleep 1;xdotool mousemove_relative 64 0;  
    done
    sleep 1;xdotool mousemove_relative -- -512 64; 
    sleep 2;
done