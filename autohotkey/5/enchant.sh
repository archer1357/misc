

function enchant() {
    rows="${1:-8}"
    cols="${2:-8}"
    let stk_amount="${3:-8}"-1
    
    
    x="${4:-150}"
    y="${5:-250}"; #550; #350;
    
    echo "x=$x, y=$y";

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
            sleep $t2;xdotool click 3;
            
            let xx1="-($j-1)*$cell_size - 1100";
            let yy1="-($i-1)*$cell_size + 620";
            let xx2=-xx1;
            let yy2=-yy1;
            
            sleep $t3;xdotool mousemove_relative -- $xx1 $yy1;

            sleep 1;xdotool click 1;
            sleep 0.5;xdotool key y; 
            
            for k in `seq 1 $stk_amount`; do 
                echo "$i $j $k";
                sleep 6;xdotool click 1;
            done
            
            #sleep 6;xdotool click 1;
            

            #sleep 4;xdotool click 1;
            sleep 4;
            
            sleep $t3;xdotool mousemove_relative -- $xx2 $yy2;

            
            let xx1="-($j-1)*$cell_size";
            let yy1="-($i-1)*$cell_size";
            let xx2=-xx1;
            let yy2=-yy1;
            
            #sleep 0.3;xdotool mousemove_relative -- $xx1 $yy1;  
            #sleep 0.5;xdotool click 1;
            #sleep 1;xdotool click 1;
            #sleep 1;xdotool mousemove_relative -- $xx2 $yy2;  
            
            sleep 1;xdotool mousemove_relative $cell_size 0;  
        done
    
        sleep 1;xdotool mousemove_relative -- -$across_size $cell_size; 
        #sleep 2;
    done
    
}


    

sleep 10;  enchant $1 $2 $3;



#sleep 11;xdotool mousemove_relative -- 500 -500;
            
#open_chests 8 8 100   100 150 30;


    #offset_x=${4:-0}
    #offset_y=${5:-0}
    #offset_x2= `expr -$offset_x`;
    #offset_y2=`expr -$offset_y`;
        
    #sleep $t;xdotool mousemove_relative -- $offset_x $offset_y; 
    #sleep $t;xdotool mousemove_relative -- $offset_x2 $offset_y2; sleep $t;
    
#mpg123 --loop 1000 f.mp3