from kafka import KafkaProducer
from kafka.errors import KafkaError
from kafka.future import log
import json
import random
import time
import re
import csv

def publish(producer, topic_name, metric_value, timestamp, unit, device_id, context):
    value = {'records': [{ 'value': { 'metric_value':(metric_value), 'timestamp':(timestamp), 'unit':(unit), 'device_id':(device_id), 'context':(context) }}]}
    print("Publishing in Kafka: %s", value)
    futures = producer.send(topic=topic_name, value=value)
    response = futures.get()
    print(response)

print("Process data from Day-2 Configuration files and save them in variables")

# Remember this file path is known in advance due to the information model proposed
day2_file_path = "/usr/bin/expb_metricId-day2-config.yml"

f = open(day2_file_path, "r")
broker_ip_address = f.readline().split(":")[1].strip() + ":9092"                    # not used if Filebeat is provided
topic_name = f.readline().split(":")[1].strip()                                     # not used if Filebeat is provided
device_id = f.readline().split(":")[1].strip()
unit = f.readline().split(":")[1].strip()
interval = f.readline().split(":")[1].strip()
interval_value = int(re.compile('([0-9]+)([a-zA-Z]+)').match(interval).group(1))    # Each $interval_value time, metric will be captured
interval_unit = re.compile('([0-9]+)([a-zA-Z]+)').match(interval).group(2)
context = f.readline().split(":")[1].strip().replace("|", " ")                      # change "|" for " "

# Transform the interval_value consequently
if interval_unit == "s":
    interval_value = interval_value/1;
elif interval_unit == "ms":
    interval_value = interval_value/1000;

# In this example, metrics are generated randomly
print("Start capturing metrics")

producer = KafkaProducer(bootstrap_servers = broker_ip_address, value_serializer=lambda x: json.dumps(x).encode('utf-8'))

n_iter=10 # for avoiding an infinite loop
for i in range(n_iter):
    print("Metric value ", i+1)
    metric_value = random.uniform(-2,2)
    timestamp = time.time()
    publish(producer, topic_name, metric_value, timestamp, unit, device_id, context)
    time.sleep(interval_value)

print("Script finished")
