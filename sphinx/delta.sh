#!/bin/bash

# for delta index data
# once each 5 min
# default config file /usr/local/sphinx/etc/csft.conf

/usr/local/sphinx/bin/indexer delta_user_info --rotate >> /opt/sphinx/log/delta_user_info.log
/usr/local/sphinx/bin/indexer delta_group --rotate >> /opt/sphinx/log/delta_group.log
/usr/local/sphinx/bin/indexer delta_social_discuss_demand --rotate >> /opt/sphinx/log/delta_social_discuss_demand.log
/usr/local/sphinx/bin/indexer delta_site_company --rotate >> /opt/sphinx/log/delta_site_company.log
/usr/local/sphinx/bin/indexer delta_site_service --rotate >> /opt/sphinx/log/delta_site_service.log
