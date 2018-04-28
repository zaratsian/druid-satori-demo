#!/bin/sh

cat<<EOF>/tmp/create_table.sql
#SET hive.druid.metadata.username=${DRUID_USERNAME};
#SET hive.druid.metadata.password=${DRUID_PASSWORD};
#SET hive.druid.metadata.uri=jdbc:mysql://dzaratsian2.field.hortonworks.com/druid;
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE if not exists cryptocurrency_market_data
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "cryptocurrency_market_data");
EOF

BEELINE="beeline -u jdbc:hive2://dzaratsian0.field.hortonworks.com:10500/default"
$BEELINE -f /tmp/create_table.sql
