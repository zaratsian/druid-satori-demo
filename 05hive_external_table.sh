#!/bin/sh

# NOTE: This does not work with Derby (use Druid with MySQL or Postgresql)
# DRUID_USERNAME=druid
# DRUID_PASSOWRD=horton.Mysql123

cat<<EOF>/tmp/create_table.sql
SET hive.druid.metadata.username=${DRUID_USERNAME};
SET hive.druid.metadata.password=${DRUID_PASSWORD};
SET hive.druid.broker.address.default=druid.example.com:8082;
#SET hive.druid.metadata.uri=jdbc:mysql://dzaratsian2.field.hortonworks.com/druid;
#SET hive.druid.coordinator.address.default=druid.example.com:8081;
CREATE EXTERNAL TABLE if not exists cryptocurrency_market_data
STORED BY 'org.apache.hadoop.hive.druid.DruidStorageHandler'
TBLPROPERTIES ("druid.datasource" = "cryptocurrency_market_data");
EOF

# Connect to Hive LLAP (Hive Interactive)
BEELINE="beeline -u jdbc:hive2://dzaratsian0.field.hortonworks.com:10500/default"
$BEELINE -f /tmp/create_table.sql

#beeline -u jdbc:hive2://dzaratsian0.field.hortonworks.com:10500/default -e "select * from cryptocurrency_market_data limit 10";

#beeline -u jdbc:hive2://dzaratsian0.field.hortonworks.com:10500/default -e "select cryptocurrency, count(*) as count from cryptocurrency_market_data group by cryptocurrency";


#ZEND
