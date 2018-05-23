# Start a supervisor task.
curl -X POST -H 'Content-Type: application/json' -d @supervisor-spec-fixed.json http://$DRUID_BROKER/druid/indexer/v1/supervisor
