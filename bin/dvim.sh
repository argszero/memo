filename=$1
password=$2

vim -R -c ":set key= | sav ${filename}.plain | q" -- ${filename} <<< $password && cat ${filename}.plain && rm ${filename}.plain
