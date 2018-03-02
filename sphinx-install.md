## sphinx install

### 1. download 
    cd /usr/local/src
    wget http://sphinxsearch.com/files/sphinx-2.2.10-release.tar.gz

### 2. install
    
#### 2.1 install sphinx
    tar -zxf sphinx-2.2.10-release.tar.gz
    cd sphinx-2.2.10-release
    ./buildconf.sh
    ./configure --prefix=/usr/local/sphinx --with-mysql
    make -j8
    make install

#### 2.2 install libsphinxclient
    
    cd api/libsphinxclient
    ./buildconf.sh
    ./configure --prefix=/usr/local/sphinx/libsphinxclient
    make 
    make install
    cd ../../../

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
    cd scws-1.2.3/
    ./configure
    make -j4
    make install
    cd phpext/
    
### start sphinx    

    # 生成配置文件
    php webroot/bin/sphinx.php
    
    # 复制sphinx脚本目录到/usr/local/sphinx/sh
    cp sphinx /usr/local/sphinx/sh -rvf
    
    # 启动sphinx服务
    indexer --all
    searchd

### 词库安装
 		wget http://www.xunsearch.com/scws/down/scws-dict-chs-utf8.tar.bz2
 		tar jxvf scws-dict-chs-utf8.tar.bz2 -C /usr/local/scws/etc/
 		chown www:www /usr/local/scws/etc/dict.utf8.xdb
 		
### sphinx的管理命令：
	1. 生成全部索引
	
	/usr/local/sphinx/bin/indexer --config /usr/local/sphinx/etc/sphinx.conf --all
	
	若此时searchd守护进程已经启动，那么需要加上—rotate参数：
	
	/usr/local/sphinx/bin/indexer --config /usr/local/sphinx/etc/sphinx.conf --all --rotate
	
	2. 启动searchd守护进程
	
	/usr/local/sphinx/bin/searchd --config /usr/local/sphinx/etc/sphinx.conf
	
	3. 生成主索引
	
	写成shell脚本，添加到crontab任务，设置成每天凌晨1点的时候重建主索引
	
	/usr/local/sphinx/bin/indexer --config /usr/local/sphinx/etc/sphinx.conf --rotate index_search_main
	
	4. 生成增量索引
	
	写成shell脚本，添加到crontab任务，设置成每10分钟运行一次
	
	/usr/local/sphinx/bin/indexer --config /usr/local/sphinx/etc/sphinx.conf --rotate index_search_main_delta
	
	5. 增量索引和主索引的合并
	
	写成shell脚本，添加到计划任务，每15分钟跑一次
	
	/usr/local/sphinx/bin/indexer --config /usr/local/sphinx/etc/sphinx.conf --merge index_search_main index_search_main_delta --rotate
	
	6. 使用search命令在命令行对索引进行检索
	
	/usr/local/sphinx/bin/search --config /usr/local/sphinx/etc/sphinx.conf
	
### 定时任务： crontab -e
	*/1 * * * * /usr/local/sphinx/sh/delta.sh >> /usr/local/sphinx/crontab.log
	30 * * * * /usr/local/sphinx/sh/merge.sh >> /usr/local/sphinx/crontab.log
	0 02 * * * /usr/local/sphinx/sh/main.sh >> /usr/local/sphinx/crontab.log
