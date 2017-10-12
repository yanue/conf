<?php

# ==== php配置 ====
$config['timezone'] = "PRC";
$config['debug'] = true;
$config['log_path'] = WEB_ROOT;

# ==== 默认应用配置 =====
$config['module'] = "home"; #默认模块
$config['controller'] = "index";
$config['action'] = "index";
$config['suffix'] = ".html"; # 请不要去掉那个'.'

$config['site_name'] = " 方圆间";
$config['webim_host'] = "101.37.24.227"; //websocket host

if (!defined('COOKIE_DOMAIN')) define('COOKIE_DOMAIN', $_SERVER['HTTP_HOST']);
if (!defined('STATIC_DOMAIN')) define('STATIC_DOMAIN', "static.bzsns.cn");
if (!defined('MAIN_DOMAIN')) define('MAIN_DOMAIN', $_SERVER['HTTP_HOST']);

return $config;
