
t=0.1
t2=0.2
t3=0.25

chests_num="${1:-10}"

num_of_stacks="${2:-64}"
#actual_num_of_stacks=`expr  ((100 / $chests_num)) \*  $num_of_stacks`

let actual_num_of_stacks="(100 / $chests_num) * $num_of_stacks";

loc1_x=800
loc1_y=270

echo "chests $chests_num"
echo "stacks $num_of_stacks"
echo "actual stacks $actual_num_of_stacks"

sleep 5;

let bla=100*num_of_stacks;
count=0;

#for i in `seq 1 $actual_num_of_stacks`; do 
while [ $count -lt $bla ]; do
    let count2=count+$chests_num;
    
    
    if [ $count2 -ge $bla ]; then
        let chests_take=$bla-$count;
    else
        let chests_take=$chests_num;
    fi
    
    let count=$count2;
    
    echo "count2 = $count2";
    echo "chests_take = $chests_take";

#break;
    #echo "$i";continue;
            sleep $t2;xdotool keydown shift;
            sleep $t3;xdotool click 1; 
            sleep $t2;xdotool keyup shift;
            
            sleep $t2;xdotool mousemove_relative 850 300; 
            sleep $t3;xdotool click 1; 
            sleep $t3;xdotool type $chests_take;
            #sleep $t2;xdotool key 1; 
            #sleep $t2;xdotool key 0; 
            #sleep $t2;xdotool key 0; 
            #break;
            #echo "a${i}_a";break;
            #sleep $t2;xdotool mousemove_relative -- -100 100; 
            sleep $t2;xdotool mousemove_relative 0 100; 
            #break;
            #sleep 10;break;
            sleep $t3;xdotool click 1; 
            #sleep $t3;xdotool mousemove_relative -- -700 -370;
            sleep $t3;xdotool mousemove_relative -- -850 -400;
done

mpg123 f.mp3 #--loop 1000