php install
===========

yum install -y gcc gcc-c++  make cmake automake autoconf kernel-devel ncurses-devel libxml2-devel openssl-devel curl-devel libjpeg-devel libpng-devel  pcre-devel libtool-libs freetype-devel gd zlib-devel file bison patch mlocate flex diffutils   readline-devel glibc-devel glib2-devel bzip2-devel gettext-devel libcap-devel libmcrypt-devel openldap openldap-devel libxslt-devel
yum install -y libpng libjpeg libpng-devel libjpeg-devel ghostscript libtiff libtiff-devel freetype freetype-devel
yum install -y librabbitmq librabbitmq-devel ffmpeg ffmpeg-devel

wget http://superb-dca2.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
wget http://cn2.php.net/get/php-7.1.0.tar.gz/from/this/mirror
1. install libmcrypt
--------------------
tar -zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --prefix=/usr
make -j8
make install
cd ..

mv mirror php7.1.0.tgz
tar -zxf php7.1.0.tgz
cd php-7.1.0
./configure --prefix=/usr/local/php \
--sysconfdir=/etc \
--with-config-file-path=/usr/local/php/etc/ \
--with-openssl \
--with-kerberos \
--with-zlib \
--with-bz2 \
--with-curl \
--with-gd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-mysql-sock=mysqlnd \
--with-mhash \
--with-mcrypt \
--with-iconv \
--with-xsl \
--with-xmlrpc \
--with-pcre-regex \
--with-gettext \
--with-jpeg-dir \
--with-png-dir \
--with-zlib-dir \
--with-freetype-dir \
--enable-cli \
--enable-calendar \
--enable-bcmath \
--enable-exif \
--enable-ftp \
--enable-gd-native-ttf \
--enable-mbstring \
--enable-mbregex \
--enable-json \
--enable-pdo \
--enable-dba \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-wddx \
--enable-fpm \
--enable-zip \
--enable-dom \
--enable-posix \
--enable-fileinfo \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-xml \
--enable-xmlwriter \
--enable-xmlreader \
--enable-maintainer-zts \
--enable-opcache

make -j16
make install

\cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm 
chmod +x /etc/init.d/php-fpm 
chkconfig php-fpm on
\cp /etc/php-fpm.conf.default /etc/php-fpm.conf -Rf
mkdir /usr/local/php/etc/
cp php.ini-* /usr/local/php/etc/
cp php.ini-production /usr/local/php/etc/php.ini
ln -sf /usr/local/php/etc/php.ini /etc/

vi /etc/php-fpm.conf
user = www
group = www

echo PATH=$PATH:/usr/local/php/bin/ >> /etc/profile
source /etc/profile

wget http://pecl.php.net/get/gmagick-2.0.4RC1.tgz

所需扩展:
redis, beast, swoole, gmagick, sphinx, fastcommon, fastdfs_client, fastdht_client, scws, amqp-1.7.1

pecl install redis
pecl install gmagick-beta

wget https://pecl.php.net/get/amqp-1.7.1.tgz
