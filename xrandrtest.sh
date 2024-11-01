#aaa= `xrandr --listactivemonitors | grep -q "1:" `
#[ -z "$aaa" ] 

if $( xrandr --listactivemonitors | grep -q "1:"  > /dev/null ) ; then

#if [ -z $(xrandr --listactivemonitors | grep -q "1:" ) ] ;  then
    echo "turn on"
    echo "'$aaa'"
    xrandr --output HDMI-2 --auto --primary --pos 0x0 --rotate normal --output HDMI-1 --auto --right-of HDMI-2     
else
  echo "turn off"
  echo "'$aaa'"
   xrandr --output HDMI-2 --auto --primary --pos 0x0 --rotate normal --output HDMI-1 --auto --right-of HDMI-2 --off
fi


#if echo "40922|OPR  12345|OPR MO 12345|12345|202|local|LMNO" | grep  "MO"
#  then echo "FOUND"
#  else echo "NOT FOUND"
#fi

#echo [ -z "$aaa" ] && echo "Empty" || echo "Not empty"