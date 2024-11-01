set -e

for x in *; 
do
	if [ -d "$x" ]; then	
	
		for y in "$x"/*;
		do

		if [ -d "$y" ]; then
			yy=$(basename "$y")
			echo "$x $yy";
			7z a "$x $yy" "$y"
		fi
		
		done
	fi
done