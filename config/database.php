<?php
# ====  ====
return array(
    'db.defaultSqlDriver' => 'mysql',
    'mysql' => array(
        'host' => '127.0.0.1', //host address
        'port' => 3306, // db server port
        'user' => 'root', // user name for dbms
        'pass' => 'qzkj@2016', // pass word for dbms
        'name' => 'ckg_test', // default selected db name
        'driver' => 'mysql'
    ),
    'sqlite' => array(
        'file' => WEB_ROOT . '/assets/admin/db/menu.db',
        'driver' => 'sqlite3'
    ),
);
