#!/bin/sh

curl -X POST 'http://dzaratsian1.field.hortonworks.com:8082/druid/v2/?pretty' -H 'content-type: application/json' -d@queries/topn_query.json

#curl -X POST 'http://dzaratsian1.field.hortonworks.com:8082/druid/v2/?pretty' -H 'content-type: application/json' -d@queries/timeseries_query.json

