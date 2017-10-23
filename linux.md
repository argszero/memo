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
# hostnamectl set-hostname Your-New-Host-Name-Here
# hostnamectl set-hostname "Your New Host Name Here" --pretty
# hostnamectl set-hostname Your-New-Host-Name-Here --static
# hostnamectl set-hostname Your-New-Host-Name-Here --transient
```
## 互信
```
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa;
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys;
chmod go-w $HOME $HOME/.ssh;chmod 600 $HOME/.ssh/authorized_keys;
```

## 其他
/usr/sbin/accton /var/account/pacct　dump-acct pacc
