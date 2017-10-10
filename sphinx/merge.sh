#!/bin/bash

# for merge main and delta data
# once each 15 min
# default config file /usr/local/sphinx/etc/csft.conf

/usr/local/sphinx/bin/indexer --merge index_user_info delta_user_info --rotate  >> /opt/sphinx/log/merge_user_info.log
/usr/local/sphinx/bin/indexer --merge index_group delta_group --rotate  >> /opt/sphinx/log/merge_group.log
/usr/local/sphinx/bin/indexer --merge index_social_discuss_demand delta_social_discuss_demand --rotate  >> /opt/sphinx/log/merge_social_discuss_demand.log
/usr/local/sphinx/bin/indexer --merge index_site_company delta_site_company --rotate  >> /opt/sphinx/log/merge_site_company.log
/usr/local/sphinx/bin/indexer --merge index_site_service delta_site_service --rotate  >> /opt/sphinx/log/merge_site_service.log