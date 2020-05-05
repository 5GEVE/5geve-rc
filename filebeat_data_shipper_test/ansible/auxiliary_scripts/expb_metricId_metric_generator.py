import random
import time
import re
import csv

print("Process data from Day-2 Configuration files and save them in variables")

# Remember these file paths are known in advance due to the information model proposed
day2_file_path = "/usr/bin/expb_metricId-day2-config.yml"
log_file_path = "/var/log/expb_metricId.log"

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

n_iter=10 # for avoiding an infinite loop
for i in range(n_iter):
    print("Metric value ", i+1)
    metric_value = random.uniform(-2,2)
    timestamp = time.time()
    with open(log_file_path, 'a', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=',') #, quotechar='|', quoting=csv.QUOTE_MINIMAL)
        writer.writerow([metric_value, timestamp, unit, device_id, context])
    time.sleep(interval_value)

print("Script finished")
