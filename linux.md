## fedora选择性粘帖
通过使用```ctrl```+```;```,可以调出选择性粘帖剪切版，选择某个历史复制信息进行粘帖

## fedora使用openvpn
需要设置```export OPENSSL_ENABLE_MD5_VERIFY=1```，比如：

```OPENSSL_ENABLE_MD5_VERIFY=1 /usr/sbin/openvpn --config /etc/openvpn/config/v5.ovpn --auth-user-pass /etc/openvpn/config/user```

## dstat:linux综合性性能监控工具
综合了vmstat, iostat, nfsstat, netstat, ifstat等的功能。

## fedora切换桌面
fedora可以使用```Ctrl```+```Alt```+```F1..F12``` 切换桌面

## centos修改主机名称
```
h_name=Your-New-Host-Name-Here
hostnamectl set-hostname $h_name
hostnamectl set-hostname $h_name --pretty
hostnamectl set-hostname $h_name --static
hostnamectl set-hostname $h_name --transient
```
## 互信
```
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa;
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys;
chmod go-w $HOME $HOME/.ssh;chmod 600 $HOME/.ssh/authorized_keys;
```

## 防火墙添加白名单
firewall-cmd --zone=public --add-port=80/tcp
firewall-cmd --zone=public --add-port=80/tcp --permanent

## 防火墙端口转发
firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8080

## 其他
/usr/sbin/accton /var/account/pacct　dump-acct pacc


## 使用rsync 拷贝文件

rsync -azPrd crmi:~/lab/lab-open-taobao-java ./

## 回复rm的文件

如果进程还没停止，可以使用lsof 查看到文件id
比如：
lsof -p 6429|grep member
java    6429 root   10u   REG              253,1 524214272     425676 /root/lab/lab-open-taobao-java/target/member.db (deleted)

然后拷贝出来就可以了：
cp /proc/6429/fd/10 restor_member.db