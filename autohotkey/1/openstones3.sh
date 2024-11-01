

function open_chests() {
    rows=$1
    cols=$2
    stk_amount=$3
    
    offset_x=${4:-0}
    offset_y=${5:-0}
    offset_x2= `expr -$offset_x`;
    offset_y2=`expr -$offset_y`;
        
    sleep $t;xdotool mousemove_relative -- $offset_x $offset_y; 
    
    x=150
    y=250; #550; #350;
    

    cell_size=64
    across_size=`expr $cols \* $cell_size`
    t=0.15
    t2=0.2
    t3=0.3

    echo "rows = $rows"
    echo "cols = $cols"
    echo "stk_amount = $stk_amount"
    echo "cell_size = $cell_size"
    echo "across_size = $across_size"

    for k in `seq 1 $rows`; do 
        echo "row $k"
        for j in `seq 1 $cols`; do 
            echo "col $j"
            for i in `seq 1 $stk_amount`; do 
                echo "stk $i"
                sleep $t2;xdotool click 3; 
                sleep $t2;xdotool mousemove_relative $x $y; 
                sleep $t2;xdotool click --repeat 2 1
                sleep $t2;xdotool key --repeat 2 f; 
                #sleep 2
                sleep $t;xdotool mousemove_relative -- -$x -$y;  
            done
            sleep 1;xdotool mousemove_relative $cell_size 0;  
        done
    
        sleep 1;xdotool mousemove_relative -- -$across_size $cell_size; 
        #sleep 2;
    done
    
    sleep $t;xdotool mousemove_relative -- $offset_x2 $offset_y2; sleep $t;
}




    

sleep 10; 
    
open_chests(64,64,100, 0,0);

#mpg123 --loop 1000 f.mp3