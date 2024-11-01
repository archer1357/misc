KEY=$(xauth list  |grep $(hostname) | awk '{ print $3 }' | head -n 1)
DCK_HOST=docker-skype
xauth add $DCK_HOST/unix:0 . $KEY

docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $HOME/.Xauthority:/tmp/.Xauthority \
           -v /dev/snd:/dev/snd \
           -e DISPLAY=unix$DISPLAY \
           -e XAUTHORITY=/tmp/.Xauthority  \
           -h $DCK_HOST \
jess/skype