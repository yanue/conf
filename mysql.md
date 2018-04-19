#配置说明：
http://ygqygq2.blog.51cto.com/1009869/1870864
datadir: /opt/mysql/data
config: /etc/my.cnf

# user and group
groupadd mysql
useradd -g mysql mysql -s /bin/false

# folder
mkdir -p /opt/mysql/data
mkdir -p /opt/mysql/log
chown -R mysql:mysql  /opt/mysql/

# install
;rpm -ivh  http://dev.mysql.com/get/mysql57-community-release-el6-11.noarch.rpm
;rpm -ivh  http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
## edit repo
vi /etc/yum.repos.d/mysql-community.repo

## install
yum -y install mysql-community-server.x86_64 mysql-community-devel.x86_64 mysql-community-client.x86_64

vi /etc/my.cnf
# 写入以下内容：
[mysqld]
user=mysql
datadir=/opt/mysql/data
socket=/tmp/mysql.sock
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
init_connect='SET collation_connection = utf8_general_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_general_ci
skip-character-set-client-handshake
max_connections=1000
sql-mode="NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" #5.6 mode
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
log-bin=mysql-bin
server-id=1
binlog-do-db=ckg          #需要记录进制日志的数据库.如果有多个数据库可用逗号分隔,或者使用多个binlog-do-db选项
binlog-ignore-db=information_schema,mysql,sys      #不需要记录进制日志的数据库.如果有多个数据库可用逗号分隔,或者使用多个binlog-do-db选项
replicate-do-db=ckg       #需要进行同步的数据库.如果有多个数据库可用逗号分隔,或者使用多个replicate-do-db选项
replicate-ignore-db=information_schema,mysql,sys     #不需要同步的数据库.如果有多个数据库可用逗号分隔,或者使用多个replicate-ignore-db选项
#同步参数:
##保证slave挂在任何一台master上都会接收到另一个master的写入信息
log-slave-updates
sync_binlog=1
auto_increment_offset=1
auto_increment_increment=2
slave-skip-errors=all             #过滤掉一些没啥大问题的错误

explicit_defaults_for_timestamp = 1


[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

[client]
default-character-set=utf8
socket=/tmp/mysql.sock

[mysql]
default-character-set=utf8
socket=/tmp/mysql.sock
#初始化数据
mysqld --initialize-insecure (--initialize为随机密码)
# 从日志查找密码
service mysqld start
set password=password("Cfg@123");

# 启动mysqld
service mysqld restart|start


#创建用户及权限
 CREATE USER "cfg"@"%" IDENTIFIED BY 'Cfg@123';
 grant all privileges on *.* to cfg@'%';
 FLUSH PRIVILEGES;
 
 CREATE USER "ckg"@"%" IDENTIFIED BY 'Ckg@123';
 grant all privileges on *.* to ckg@'%';
 FLUSH PRIVILEGES;

 CREATE USER "ckg_reader"@"%" IDENTIFIED BY 'CkgReader@123';
 GRANT SELECT, SHOW VIEW, PROCESS, SUPER, REPLICATION CLIENT ON *.* TO ckg_reader@'%';
 FLUSH PRIVILEGES;
 
 CREATE USER "replication"@"%" IDENTIFIED BY 'cfg-replication';
 grant replication slave,file on *.* to 'replication'@'%' identified by 'cfg-replication';
 FLUSH PRIVILEGES;

## mysql 双主机模式
主主配置过程

1、创建同步用户：

服务器A：

 grant replication slave,file on *.* to 'replication'@'cfg-im' identified by 'cfg-replication';

flush privileges;

服务器B：

grant replication slave,file on *.* to 'replication'@'cfg-web' identified by 'cfg-replication';

flush privileges;


mysql>flush tables with read lock;
mysql>show master status\G
*************************** 1. row ***************************
             File: mysql-bin.000066
         Position: 71710056
     Binlog_Do_DB: ckg
 Binlog_Ignore_DB: information_schema,mysql,sys
Executed_Gtid_Set:
1 row in set (0.00 sec)
*************************** 1. row ***************************
             File: mysql-bin.000065
         Position: 876898714
     Binlog_Do_DB: ckg
 Binlog_Ignore_DB: information_schema,mysql,sys
Executed_Gtid_Set:
1 row in set (0.00 sec)
mysql>unlock tables;


服务器A:
change master to master_host='cfg-im',master_user='replication',master_password='cfg-replication',master_log_file='mysql-bin.000004',master_log_pos=154,MASTER_CONNECT_RETRY=60;

服务器B:
change master to master_host='cfg-web',master_user='replication',master_password='cfg-replication',master_log_file='mysql-bin.000008',master_log_pos=154,MASTER_CONNECT_RETRY=60;

start slave;
stop slave;
show slave status\G