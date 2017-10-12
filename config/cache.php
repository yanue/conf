<?php
return array(
    'cache.defaultDriver' => "redis",
    'cache.backUp' => 'apc',
    'cache.keyPrefix' => 'ckg_',
    'cache.drivers.redis' => array(
        'host' => '127.0.0.1',
        'port' => '6280',
        'timeout' => 2, //秒
        'password' => 'ckg-redis'
    ), //把redis当缓存服务器使用

);
