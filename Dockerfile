FROM centos

RUN sed -i "s|plugins=1|plugins=0|g" /etc/yum.conf

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup\
	&& curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo\
	&& rpm -ivh https://mirrors.aliyun.com/centos/7.5.1804/extras/x86_64/Packages/epel-release-7-11.noarch.rpm\
	&& yum makecache

RUN yum install -y net-tools vim wget which telnet killall pstree htop psmisc\
	&& yum groupinstall -y "development tools"

RUN echo 'alias vi="vim"' >> /etc/bashrc\
	&& echo 'alias nets="netstat -ntpl"' >> /etc/bashrc\
	&& echo "PATH=/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/bashrc\
	&& echo 'export GOPATH=/opt/go' >> /etc/bashrc\
	&& echo 'export GOROOT=/usr/local/go' >> /etc/bashrc\
	&& echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> /etc/bashrc

CMD source /etc/bashrc

RUN cd /usr/local/src\
	&& wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz\
 	&& tar -xzf go1.11.2.linux-amd64.tar.gz\
 	&& mv go /usr/local/go

# docker build -t centos-go .
# docker run -d --privileged -v /Users/yanue/golang:/opt/go centos-go /usr/sbin/init
