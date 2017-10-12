<?php

if (!defined('UPLOAD_DIR')) define('UPLOAD_DIR', '/opt/ckg_uploads');
/** 上传及相应格式配置 **/
$config['uploadSaveType'] = 'normal'; # normal|fdfs
$config['baseUrl'] = 'http://dev.bzsns.cn';
/**
 * upload pic
 */
$config['pic'] = array(
    'adpter' => 'fdfs', //[fdfs, local]
    'fastDFS' => [
        'tracker_host' => '101.37.24.227',
        'tracker_port' => '22121',
        'group' => 'pic',
    ],
    'maxAttachSize' => '3072000',
    'ext' => 'jpg|jpeg|gif|png|bmp|ico',
);

/**
 * upload file
 */
$config['file'] = [
    'fastDFS' => [
        'tracker_host' => '101.37.24.227',
        'tracker_port' => '22122',
        'group' => 'media',
    ],
    'maxAttachSize' => '52428800', # 50M=50x1024x1024
    'ext' => 'zip|rar|doc|xls|ppt|docx|pptx|xlsx|txt|png|vcf|webm',
];

/**
 * upload audio
 */
$config['audio'] = [
    'fastDFS' => [
        'tracker_host' => '101.37.24.227',
        'tracker_port' => '22122',
        'group' => 'media',
    ],
    'maxAttachSize' => '5242880', # 5M=5x1024x1024
    'ext' => 'mp3|m4a|ogg|spx|oga|amr|wav',
];

/**
 * upload video
 */
$config['video'] = [
    'fastDFS' => [
        'tracker_host' => '101.37.24.227',
        'tracker_port' => '22122',
        'group' => 'media',
    ],
    'maxAttachSize' => '20971520', # 20M=20x1024x1024
    'ext' => 'mp4|3gp|ogg|webm|flv|f4v|m4v',
];

return $config;
