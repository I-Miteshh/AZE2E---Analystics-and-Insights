from kafka import KafkaProducer
import json
import time
import random

# Function to simulate Uber pickups data
def generate_uber_pickup():
    return {
        "pickup_time": time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime()),
        "pickup_lat": round(random.uniform(40.6, 40.9), 6),
        "pickup_long": round(random.uniform(-74.1, -73.7), 6)
    }

# Kafka producer configuration
producer = KafkaProducer(
    bootstrap_servers='your_eventhub_namespace.servicebus.windows.net:9093',
    value_serializer=lambda v: json.dumps(v).encode('utf-8'),
    security_protocol="SASL_SSL",
    sasl_mechanism="PLAIN",
    sasl_plain_username="$ConnectionString",
    sasl_plain_password="your_eventhub_connection_string"
)

# Send data continuously
while True:
    pickup_data = generate_uber_pickup()
    producer.send('uber-pickups', value=pickup_data)
    print(f"Sent: {pickup_data}")
    time.sleep(5)
