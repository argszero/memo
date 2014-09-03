memo
====

备忘录

Pentadactyl
----

* 如何保存配置
 * :mkp
* 如何修改默认的搜索引擎
 * :set defsearch=aol-web-search

Linux
----

* 如何按日期分割nohup的输出文件
 * 新建一个管道
 * 建立定时任务，每天将管道的内容定向到不同文件
 * 将nohup输出到此管道
* 例
  * 新建管道: mknod mypipe p
  * 建立定时任务，每天将管道的内容定向到不同文件
   * 新建脚本:<pre>
cat << EOF > rolllog.sh
> dir=$(cd $(dirname $BASH_SOURCE); pwd)
> lsof $dir/xxx.log|tail -1|awk '{print "kill " $2}'|sh
> mv $dir/xxx.log $dir/spark-sql-`date +%Y%m%d%H%M`.log
> nohup cat < $dir/mypipe >> $dir/xxx.log & > /dev/null 2>&1
> EOF
  </pre>
  * 定时执行脚本： crontab -e 0 * * * * /XX/rolllog.sh
 * 将nohup输出到此管道: nohup xxx.sh > $dir/mypipe 2>&1 &
