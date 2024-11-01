rows=1
cols=1
stk_amount=64

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

sleep 10; 
for k in `seq 1 $rows`; do 
    echo "row $k"
    for j in `seq 1 $cols`; do 
        echo "col $j"
        for i in `seq 1 $stk_amount`; do 
            echo "stk $i"
            sleep $t2;xdotool click 3; 
            sleep $t2;xdotool mousemove_relative 150 250; 
            #sleep $t2;xdotool mousemove_relative 150 550; 350
            sleep $t2;xdotool click --repeat 2 1
            sleep $t2;xdotool key --repeat 2 f; 
            #sleep 2
            sleep $t;xdotool mousemove_relative -- -150 -250;  
            #sleep $t;xdotool mousemove_relative -- -150 -550;  
        done
        sleep 1;xdotool mousemove_relative $cell_size 0;  
    done
    sleep 1;xdotool mousemove_relative -- -$across_size $cell_size; 
    #sleep 2;
done

#mpg123 --loop 1000 f.mp3