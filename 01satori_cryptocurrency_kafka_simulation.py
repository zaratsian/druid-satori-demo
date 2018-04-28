
#!/usr/bin/env python

##########################################################################################################
#
#   Satori Cryptocurrency Simulator
#   This script is meant to simulate data that would flow through the satori cryto feed
#
##########################################################################################################


import json
import kafka
import sys,re
import random
import time, datetime

simulate_feed   = True

kafka_endpoint  = "dzaratsian1.field.hortonworks.com:6667"

endpoint        = "wss://open-data.api.satori.com"
appkey          = "APP_KEY"
channel         = "cryptocurrency-market-data"
simulate_feed   = True


def main():
    
    count = 0
    
    kafka_topic    = re.sub('[^a-zA-Z0-9]','_',channel)
    kafka_producer = kafka.KafkaProducer(bootstrap_servers=kafka_endpoint)
    
    print('[ INFO ] Using Kafka Topic = ' + str(kafka_topic))
    time.sleep(5)
    
    if simulate_feed == False:
        
        from satori.rtm.client import make_client, SubscriptionMode
        
        with make_client(endpoint=endpoint, appkey=appkey) as client:
            class SubscriptionObserver(object):
                def on_subscription_data(self, data):
                    for message in data['messages']:
                        message['_timestamp'] = int(time.time())
                        kafka_producer.send(kafka_topic, bytes(json.dumps(message)))
                        count += 1
            
            subscription_observer = SubscriptionObserver()
            client.subscribe(
                channel,
                SubscriptionMode.SIMPLE,
                subscription_observer)
            
            try:
                while True:
                    time.sleep(1)
                    print("Messages sent to Kafka: " + str(count))
            except KeyboardInterrupt:
                pass
    
    elif simulate_feed == True:
        while True:
            time.sleep(1)
            # Simulate Data Feed
            datetimestamp = datetime.datetime.now()
            payload = random.choice([
                {"cryptocurrency":"BTC", "name":"bitcoin",      "price":round(random.triangular(7000,13000,9282),2)},
                {"cryptocurrency":"BCH", "name":"bitcoin cash", "price":round(random.triangular(400,800,650),2)},
                {"cryptocurrency":"ETH", "name":"ethereum",     "price":round(random.triangular(400,800,650),2)},
                {"cryptocurrency":"LTC", "name":"litecoin",     "price":round(random.triangular(1200,1600,1400),2)},
            ])
            message = {
              "exchange": random.choice(['Coinbase','Coinmama','Bitpanda','Kraken','cex.io']),
              "cryptocurrency": payload['cryptocurrency'],
              "basecurrency": "USD",
              "type": "market",
              "price": payload['price'],
              "size": random.randint(1,100),
              "bid": round(payload['price']*random.triangular(0.95,1,0.98),2),
              "ask": round(payload['price']*random.triangular(1,1.05,1.1),2),
              "open": round(payload['price']*random.triangular(0.95,1.05,1),2),
              "high": round(payload['price']*random.triangular(0.95,1.05,1),2),
              "low": round(payload['price']*random.triangular(0.95,1.05,1),2),
              "volume": random.randint(1,10000),
              "_timestamp": int(time.time()),
              "timestamp": datetimestamp.strftime('%Y-%m-%dT%H:%M:%S.%fZ')
            }
            kafka_producer.send(kafka_topic, json.dumps(message).encode('utf-8'))
            count += 1
            print("Messages sent to Kafka: " + str(count))
            print(json.dumps(message))
    
    else:
        print('[ ERROR ] Simulate_feed variable may not set and also check to make sure Kafka host and port are correct.')
        sys.exit()


if __name__ == '__main__':
    main()


#ZEND
