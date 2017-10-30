
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
