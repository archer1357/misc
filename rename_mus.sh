set -e


for f in ./*.mp3 ./**/*.mp3 ./**/**/*.mp3 ;
do
	if [ -f "$f" ]; then
		DIR=$(dirname "${f}")
		DIR2=$(echo $DIR | sed -e 's/\.\///g')
		DIR3=$(echo $DIR2 | sed -e 's/\// - /g')
		NAME=$(basename "${f}")

		echo "${DIR3} - ${NAME}";
		mv "$f" "${DIR3} - ${NAME}"
	fi
done