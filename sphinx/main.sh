#!/bin/bash

# for main index data
# once each one day
# default config file /usr/local/sphinx/etc/csft.conf

/usr/local/sphinx/bin/indexer index_user_info --rotate >> /opt/sphinx/log/index_user_info.log
/usr/local/sphinx/bin/indexer index_group  --rotate >> /opt/sphinx/log/index_group.log
/usr/local/sphinx/bin/indexer index_social_discuss_demand --rotate >> /opt/sphinx/log/index_social_discuss_demand.log
/usr/local/sphinx/bin/indexer index_site_company --rotate >> /opt/sphinx/log/index_site_company.log
/usr/local/sphinx/bin/indexer index_site_service --rotate >> /opt/sphinx/log/index_site_service.log
