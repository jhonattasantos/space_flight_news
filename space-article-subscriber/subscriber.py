import pika
import requests
import json


class Subscriber:
    def __init__(self, config):
        self.config = config

    def consumer(self, routing_key: str, callback):
        connection = self.create_connection()
        channel = connection.channel()

        channel.queue_declare(
            queue=routing_key
        )

        channel.basic_consume(on_message_callback=callback, queue=routing_key,auto_ack=True)
        print("[*] Waiting for messages. To exit press CTRL+C")
        channel.start_consuming()

    def create_connection(self):
        param = pika.ConnectionParameters(
            host=self.config['host'],
            port=self.config['port']
        )
        return pika.BlockingConnection(param)


# class HttpRequest:
#     def __init__(self, config):
#         self.config = config

#     def get(self, url, params=''):
#         return requests.get(url=f"{self.config['base_url']}/{url}", params=params)


print("Started Subscriber")

def callback(ch, method, properties, body):
    headers = {
        'Content-Type': 'application/json'
    }
    r = requests.post('http://space-rails-api:3000/articles', data=body, headers=headers)
    print(f"[X] status: {r.status_code}")

config = { 'host': 'space-queue', 'port': 5672, 'exchange': ''}
subscriber = Subscriber(config=config)
subscriber.consumer('spaceflightnewsapi', callback=callback)

print("Ended Subscriber")
