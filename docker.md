# 开启权限
docker run -d --privileged -v /Users/yanue/golang:/opt/go  centos  /usr/sbin/init

# 安装基础包
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

rpm -ivh https://mirrors.aliyun.com/centos/7.5.1804/extras/x86_64/Packages/epel-release-7-11.noarch.rpm

yum install -y net-tools vim wget which openssh  openssh-server openssh-clients telnet network-manager-applet
yum groupinstall “development tools”

# 设置镜像
docker commit -m “init env” c3cc76a9736e  centos-go:latest 
docker run -d --privileged -v /Users/yanue/golang:/opt/go  -p 3812:3812  --name  test1 centos-go  /usr/sbin/init
