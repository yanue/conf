#1 install
 yum install -y monit
 chkconfig monit on
 
#2 config conf
 vi /etc/monit.conf

##2.1 httpd setting

 set httpd port 2812
     allow admin:monit      # require user 'admin' with password 'monit'

 or

 set httpd port 2812 and
    use address your.ip.address  # only accept connection from localhost
    allow 0.0.0.0/0.0.0.0        # allow localhost to connect to the server and
    allow admin:a_password      # require user 'admin' with password 'monit'

##2.1 mail setting

    set mailserver  mail.estt.com.cn
    username "yxyang@estt.com.cn" password "402407"

    set mail-format {
        from:    Monit <monit@$HOST>
        subject: monit alert --  $EVENT $SERVICE
        message: $EVENT Service $SERVICE
             Date:        $DATE
             Action:      $ACTION
             Host:        $HOST
             Description: $DESCRIPTION
    }

    set alert yxyang@estt.com.cn not on { instance, action }

##2.2 start

 service monit start
