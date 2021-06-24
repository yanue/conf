# 单网卡绑定多ip

## centos7及以下

### 立即生效

```
ifconfig eth0:0 broadcast 172.31.3.151
```

### 永久生效

vi /etc/sysconfig/network-scripts/ifcfg-eth0:0

```
DEVICE=eth0:0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
IPADDR=172.31.3.151 
NETMASK=255.255.240.0 
```

> 注意更改DEVICE及IPADDR即可

```
systemctl restart network
systemctl status network
```

# centos8

> 查看 https://www.cnblogs.com/syavingcs/p/14797060.html

### 立即生效

```shell
ip addr add 172.31.0.201/20 dev eth0  ## 1、将新的私有IP添加到该实例的网络接口 
ip addr list dev eth0 ## 3、查看已添加的私有IP
```

### 永久生效(重启后生效)

vi /etc/sysconfig/network-scripts/ifcfg-eth0:0

```
DEVICE=eth0:0
IPADDR=172.31.3.188
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
NETMASK=255.255.240.0
```

> 注意更改DEVICE及IPADDR即可
