## fedora选择性粘帖
通过使用```ctrl```+```;```,可以调出选择性粘帖剪切版，选择某个历史复制信息进行粘帖

## fedora使用openvpn
需要设置```export OPENSSL_ENABLE_MD5_VERIFY=1```，比如：

```OPENSSL_ENABLE_MD5_VERIFY=1 /usr/sbin/openvpn --config /etc/openvpn/config/v5.ovpn --auth-user-pass /etc/openvpn/config/user```

## dstat:linux综合性性能监控工具
综合了vmstat, iostat, nfsstat, netstat, ifstat等的功能。

##其他
/usr/sbin/accton /var/account/pacct　dump-acct pacc
