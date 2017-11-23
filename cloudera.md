## ```Activity Monitor```处于```正在停止```状态，导致无法操作
 因为某种原因，导致```Activity Monitor```停止操作未能完成，这种情况下，即不能重新停止，也不能启动、重启、删除。出现这种情况可以通过手动修改cloudera-scm-server数据库里的状态记录解决。
 
 查看/etc/cloudera-scm-server/db.properties,连接这个数据库，执行类似如下命令
 ```select * from roles where role_type='ACTIVITYMONITOR';```
 查看```configured_status```字段是否为```STOPPING```,如果是，则修改为```STOPPED```
