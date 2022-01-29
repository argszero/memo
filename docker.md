
## 修改默认存储位置：
vim /etc/docker/daemon.json
```
{
  "graph": "/docker"
}
```
## 非root用户使用docker命令
https://docs.docker.com/engine/installation/linux/linux-postinstall/#manage-docker-as-a-non-root-user
```
sudo groupadd docker
udo usermod -aG docker $USER
```
## 通过ssh直接连接docker container
https://docs.docker.com/engine/examples/running_ssh_service/

对于centos,需要在修改sshd_config之前，先生成，即添加
```RUN /usr/bin/ssh-keygen -A```


限制一个主机上所有docker容器的CPU使用
vim /etc/systemd/system/docker_limit.slice
[Unit]
Description=Slice that limits docker resources
Before=slices.target

[Slice]
CPUAccounting=true
CPUQuota=140%
#Memory Management
#MemoryAccounting=true
#MemoryLimit=2G

 systemctl start docker_limit.slice
 systemctl daemon-reload
 systemctl start docker_limit.slice