## sphinx install

### 1. download 
    cd /usr/local/src
    ;git clone https://github.com/sphinxsearch/sphinx.git
    wget http://sphinxsearch.com/files/sphinx-2.2.10-release.tar.gz
    wget -c http://pecl.php.net/get/sphinx-1.3.3.tgz

### 2. install
    
#### 2.1 install sphinx
    tar -zxf sphinx-2.2.10-release.tar.gz
    cd sphinx-2.2.10-release
    ./buildconf.sh
    ./configure --prefix=/usr/local/sphinx --with-mysql
    make -j16
    make install

#### 2.2 install libsphinxclient
    
    cd api/libsphinxclient
    ./buildconf.sh
    ./configure --prefix=/usr/local/sphinx/libsphinxclient
    make 
    make install
    cd ../../

#### 2.3 install php extension
  
    wget https://github.com/php/pecl-search_engine-sphinx/archive/php7.zip -O pecl-search_engine-sphinx-php7.zip   
    unzip pecl-search_engine-sphinx-php7.zip
    cd pecl-search_engine-sphinx-php7
    phpize
    ./configure --with-sphinx=/usr/local/sphinx/libsphinxclient
    make -j8 
    make install
    
 add to php.ini
    
    echo "[Sphinx]" >> /etc/php.ini
    echo "extension = sphinx.so" >> /etc/php.ini
    

### config sphinx
    
    see: [http://yanue.net/post-129.html]
    
    
### start searchd
    
    add to evenirment
    vi /etc/profile 
    
    export PATH=$PATH:/usr/local/sphinx/bin
    source /etc/profile
    
### create folder

    mkdir -p /opt/sphinx/data/
    mkdir -p /opt/sphinx/log/
    
### start and add to crontab
    wget -q -O - http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2 | tar xjf -
    