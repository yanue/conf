### fst
1. 修改hostname
/etc/sysconfig/network
ssh-keygen -t rsa -b 4096 -C "dev@estt.com.cn"

2. 同步时间
\cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yum -y install ntp
ntpdate 0.centos.pool.ntp.org


3. 更改镜像
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum clean all
yum makecache

4. 2台密钥免密码互相登录
ssh-keygen -t rsa -b 4096 -C 

5. 磁盘分区: https://help.aliyun.com/document_detail/25426.html
磁盘分区为 opt
echo '/dev/xvdb1  /opt ext4    defaults    0  0' >> /etc/fstab

6. 基础软件
yum -y install epel-release
yum -y install yum-priorities
yum -y groupinstall "development tools"

7. repoforge安装
 http://repoforge.org/use/
 yum install git --enablerepo=rpmforge-extras
 
8. 改selinux
直接生效
setenforce 0
设置SELINUX=disabled
vi /etc/selinux/config  


9. 设置go源
 https://go-repo.io/

10. 安装顺序
fastdfs
fastdht
nginx
php
php扩展
mysql
sphinx
monit
go
redis