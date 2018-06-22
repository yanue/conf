install freetds
---------------
    http://mirrors.ibiblio.org/freetds/stable/
    ./configure --with-tdsver=8.0 --prefix=/usr/local/freetds --enable-msdblib --enable-sybase-compat --with-gnu-ld --enable-shared --enable-static

Install pdo_dblib
-----------------
进入php源码ext目录找到pdo_dblib

Cannot find FreeTDS in known installation directories

If you are receiving this error there are two things that need to be done.
First you need to:

    sudo touch /usr/local/freetds/include/tds.h
    sudo touch /usr/local/freetds/lib/libtds.a
Next in the PDO directory run

    ./configure --with-pdo-dblib=/usr/local/freetds

# config freetds.conf
    vi /usr/local/freetds/etc/freetds.conf

    append to [global] 
            host = remote ms sql server host
            port = 1433
            tds version = 8.0
            client charset = UTF-8
