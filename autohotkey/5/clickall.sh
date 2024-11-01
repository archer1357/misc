

function clickall() {
    rows="${1:-8}"
    cols="${2:-8}"
    
    

    cell_size=64 #"${6:-64}"
    across_size=`expr $cols \* $cell_size`
    t=0.25;#0.15
    t2=0.25;#0.2
    t3=0.65;#0.3

    echo "rows = $rows"
    echo "cols = $cols"
    echo "stk_amount = $stk_amount"
    echo "cell_size = $cell_size"
    echo "across_size = $across_size"

    for i in `seq 1 $rows`; do 
        echo "row $i"
        for j in `seq 1 $cols`; do 
            echo "col $j"
            sleep 0.5;xdotool click 1;
            sleep 0.5;xdotool key y; 
            
            
            sleep 0.5;xdotool mousemove_relative $cell_size 0;  
        done
    
        sleep 0.5;xdotool mousemove_relative -- -$across_size $cell_size; 
        #sleep 2;
    done
    
}



    

#sleep 10;  enchant 8 8 3;
sleep 10;  clickall $1 $2;


#sleep 11;xdotool mousemove_relative -- 500 -500;
            
#open_chests 8 8 100   100 150 30;


    #offset_x=${4:-0}
    #offset_y=${5:-0}
    #offset_x2= `expr -$offset_x`;
    #offset_y2=`expr -$offset_y`;
        
    #sleep $t;xdotool mousemove_relative -- $offset_x $offset_y; 
    #sleep $t;xdotool mousemove_relative -- $offset_x2 $offset_y2; sleep $t;
    
#mpg123 --loop 1000 f.mp3