import pika
import requests
import json


class Publisher:
    def __init__(self, config):
        self.config = config

    def publish(self, routing_key, message):
        connection = self.create_connection()
        channel = connection.channel()

        channel.queue_declare(
            # exchange=self.config['exchange'],
            # exchange_type='direct'
            queue=routing_key
        )

        channel.basic_publish(
            exchange=self.config['exchange'],
            routing_key=routing_key,
            body=message
        )
        print(f"[X] Sent message {routing_key}")

    def create_connection(self):
        param = pika.ConnectionParameters(
            host=self.config['host'],
            port=self.config['port']
        )
        return pika.BlockingConnection(param)


class HttpRequest:
    def __init__(self, config):
        self.config = config

    def get(self, url, params=''):
        return requests.get(url=f"{self.config['base_url']}/{url}", params=params)


print("Started Publisher")

config_request_local = {
    'base_url': 'http://space-rails-api:3000'
}
request = HttpRequest(config_request_local)
last_article_local = request.get(url='articles', params={'last': True}).json()
last_origin_id = 0
if (len(last_article_local) > 0):
    last_origin_id = last_article_local[0]['origin_id']

print(f"Local: {last_origin_id}")
config_request_space_flight = {
    'base_url': 'https://api.spaceflightnewsapi.net/v3'
}
request = HttpRequest(config_request_space_flight)
last_article_api = request.get(url='articles', params={'_limit': 1}).json()
last_id_registed = last_article_api[0]['id']
print(f"API: {last_id_registed}")

if int(last_origin_id) < int(last_id_registed):
    request = HttpRequest(config_request_space_flight)
    data = request.get(url='articles', params={'_limit': last_id_registed}).json()
    res = list(filter(lambda x: (int(x['id']) > int(last_origin_id)), data))
    for d in res:
        config = { 'host': 'space-queue', 'port': 5672, 'exchange': ''}
        publisher = Publisher(config)
        publisher.publish('spaceflightnewsapi', json.dumps(d))
        print(f"[X] Sent {d['title']}")

print("Ended Publisher")
