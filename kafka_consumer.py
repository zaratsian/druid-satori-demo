import datetime,re
from pykafka import KafkaClient

kafka_topic = 'cryptocurrency_market_data'.encode('utf-8')

client = KafkaClient(hosts="dzaratsian2.field.hortonworks.com:6667")

client.topics

topic    = client.topics[kafka_topic]
consumer = topic.get_simple_consumer()

for message in consumer:
     if message is not None:
         print(message.offset, message.value)

#ZEND
