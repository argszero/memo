# 笔记本共享wifi网络给手机

## 现状及要求：
* 1. 笔记本一台ThinkPadT440p，通过有线+代理上网
* 2. 要求手机通过笔记本共享的wifi直接上网，不需手机侧配置代理

## 步骤
 * 1. 检查网卡及驱动是否支持
  * 1.1 查找无线网卡设备名称：
```
        lshw -C network
```
```
        ...
        description: Wireless interface
        ...
        logical name: wlp4s0
        ...
```
```
        lspci -k | grep -A 3 -i "network"
```
```
        Kernel driver in use: iwlwifi
```
```
        /usr/sbin/iw dev
```
```
        phy#0
	          Interface wlp4s0
             		ifindex 3
             		wdev 0x1
             		addr 28:b2:bd:45:ae:e8
             		ssid ap4argszero
             		type AP
             		channel 6 (2437 MHz), width: 20 MHz (no HT), center1: 2437 MHz
```
```
        /usr/sbin/iw phy#0 info
```
```
            Supported interface modes:
              * IBSS 
              * managed 
              * AP
              * AP/VLAN
              * monitor
              * P2P-client
              * P2P-GO
              * P2P-device

```
  * 最后这一步，支持的接口模式里如果包含AP，则说明支持AP模式
