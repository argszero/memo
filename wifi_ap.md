# 笔记本共享wifi网络给手机

## 现状及要求：
* 1. 笔记本一台ThinkPadT440p，通过有线+代理上网
* 2. 要求手机通过笔记本共享的wifi直接上网，不需手机侧配置代理

## 步骤
 * 1. 检查网卡及驱动是否支持
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
 * 2. 安装hostapd
```
        yum install hostapd
```
 * 3. 配置hostapd
```
        vim /etc/hostapd/hostapd.conf
```
```
        interface=wlp4s0
	driver=nl80211
	ssid=ap4argszero
	hw_mode=g
	channel=6
	macaddr_acl=0
	auth_algs=1
	ignore_broadcast_ssid=0
	wpa=3
	wpa_passphrase=12345678
	wpa_key_mgmt=WPA-PSK
	wpa_pairwise=TKIP
	rsn_pairwise=CCMP
```
其中ssid，wpa_passphrase分别为共无线名称和秘密，可随填写
 * 4. 安装dhcp
```
        yum install dhcp
```
 * 5. 配置dhcp
```
        vim /etc/dhcp/dhcpd.conf
```
```
        #
	# DHCP Server Configuration file.
	#   see /usr/share/doc/dhcp/dhcpd.conf.example
	#   see dhcpd.conf(5) man page
	#
	
	ddns-update-style none;
	ignore client-updates;
	authoritative;
	option local-wpad code 252 = text;
	 
	subnet
	10.0.0.0 netmask 255.255.255.0 {
	# --- default gateway
	option routers
	10.0.0.1;
	# --- Netmask
	option subnet-mask
	255.255.255.0;
	# --- Broadcast Address
	option broadcast-address
	10.0.0.255;
	# --- Domain name servers, tells the clients which DNS servers to use.
	option domain-name-servers
	10.0.0.1, 8.8.8.8, 8.8.4.4;
	option time-offset
	0;
	range 10.0.0.3 10.0.0.13;
	default-lease-time 1209600;
	max-lease-time 1814400;
	}
```
 * 6. 安装squid
```
        yum install squid
```
 * 7. 配置squid
```
        vim /etc/squid/squid.conf
```
```
        #
	# Recommended minimum configuration:
	#
	
	# Example rule allowing access from your local networks.
	# Adapt to list your (internal) IP networks from where browsing
	# should be allowed
	acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
	acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
	acl localnet src 192.168.0.0/16	# RFC1918 possible internal network
	acl localnet src fc00::/7       # RFC 4193 local private network range
	acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines
	
	acl SSL_ports port 443
	acl Safe_ports port 80		# http
	acl Safe_ports port 21		# ftp
	acl Safe_ports port 443		# https
	acl Safe_ports port 70		# gopher
	acl Safe_ports port 210		# wais
	acl Safe_ports port 1025-65535	# unregistered ports
	acl Safe_ports port 280		# http-mgmt
	acl Safe_ports port 488		# gss-http
	acl Safe_ports port 591		# filemaker
	acl Safe_ports port 777		# multiling http
	acl CONNECT method CONNECT
	
	#
	# Recommended minimum Access Permission configuration:
	#
	# Deny requests to certain unsafe ports
	http_access deny !Safe_ports
	
	# Deny CONNECT to other than secure SSL ports
	http_access deny CONNECT !SSL_ports
	
	# Only allow cachemgr access from localhost
	http_access allow localhost manager
	http_access deny manager
	
	# We strongly recommend the following be uncommented to protect innocent
	# web applications running on the proxy server who think the only
	# one who can access services on "localhost" is a local user
	#http_access deny to_localhost
	
	#
	# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
	#
	
	# Example rule allowing access from your local networks.
	# Adapt localnet in the ACL section to list your (internal) IP networks
	# from where browsing should be allowed
	http_access allow localnet
	http_access allow localhost
	
	# And finally deny all other access to this proxy
	http_access deny all
	
	# Squid normally listens to port 3128
	cache_peer 10.1.1.21  parent 8080 0 no-query proxy-only login=ailk\userxx:pwdxx connect-timeout=10
	never_direct allow all
	#透明
	http_port 3128 transparent
	
	# Uncomment and adjust the following to add a disk cache directory.
	#cache_dir ufs /var/spool/squid 100 16 256
	
	# Leave coredumps in the first cache dir
	coredump_dir /var/spool/squid
	
	#
	# Add any of your own refresh_pattern entries above these.
	#
	refresh_pattern ^ftp:		1440	20%	10080
	refresh_pattern ^gopher:	1440	0%	1440
	refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
	refresh_pattern .		0	20%	4320
	
	log_mime_hdrs on
```
 * 8. 编写启动脚本
```
        vim initSoftAP
```
```
#!/bin/bash
#Initial wifi interface configuration
ifconfig wlp4s0 down
ifconfig wlp4s0 up 10.0.0.1 netmask 255.255.255.0
sleep 2
###########Start DHCP, comment out / add relevant section##########
#Thanks to Panji
#Doesn't try to run dhcpd when already running
if [ "$(ps -e | grep dhcpd)" == "" ]; then
dhcpd wlp4s0 &
fi
###########
#Enable NAT
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
iptables --table nat --append POSTROUTING --out-interface em1 -j MASQUERADE
iptables --append FORWARD --in-interface wlp4s0 -j ACCEPT

iptables -t nat -A PREROUTING -i wlp4s0 -p tcp --match multiport --dports 1:24 -j REDIRECT --to-port 3128
iptables -t nat -A PREROUTING -i wlp4s0 -p tcp --match multiport --dports 26:109 -j REDIRECT --to-port 3128
iptables -t nat -A PREROUTING -i wlp4s0 -p tcp --match multiport --dports 111:442 -j REDIRECT --to-port 3128
iptables -t nat -A PREROUTING -i wlp4s0 -p tcp --match multiport --dports 444:3127 -j REDIRECT --to-port 3128
iptables -t nat -A PREROUTING -i wlp4s0 -p tcp --match multiport --dports 3129:65535 -j REDIRECT --to-port 3128

sysctl -w net.ipv4.ip_forward=1
#start hostapd
#hostapd /etc/hostapd/hostapd.conf 1>/dev/null
rfkill unblock wlan
hostapd /etc/hostapd/hostapd.conf 1>hostapd.log
killall dhcpd
```
 * 9. 启动
  * 1. 选择无线网卡，选择Turn Off
  * 2. nohup ./initSoftAP&
