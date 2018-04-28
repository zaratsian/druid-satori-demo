#!/bin/sh

cat<<EOF>/tmp/create_table.sql
#SET hive.druid.metadata.username=${DRUID_USERNAME};
#SET hive.druid.metadata.password=${DRUID_PASSWORD};
#SET hive.druid.metadata.uri=jdbc:mysql://dzaratsian2.field.hortonworks.com/druid;
SET hive.druid.broker.address.default=druid.example.com:8082;
CREATE EXTERNAL TABLE if not exists cryptocurrency_market_data
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "cryptocurrency-market-data");
EOF

HS2=${1:-localhost:10500} #HIVE LLAP HOST:PORT
BEELINE="beeline -u jdbc:hive2://$HS2/default"
$BEELINE -f /tmp/create_table.sql
