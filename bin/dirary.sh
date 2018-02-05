this="${BASH_SOURCE-$0}"
cdir=$(cd -P -- "$(dirname -- "$this")" && pwd -P)
app_dir=$(cd $cdir/..;pwd)
echo $app_dir

days=$1
if [ $days == ""]
	then
 		days=0
fi
echo `date -v-${days}d +"%Y%m%d"`
dir=$app_dir/dirary/`date -v-${days}d +"%Y%m"`
mkdir -p $dir
cd $dir
vim `date -v-${days}d +"%Y%m%d"`.md

