import random
import time
import re
import csv

print("Process data from Day-2 Configuration files and save them in variables")

# Remember these file paths are known in advance due to the information model proposed
day2_file_path = "/usr/bin/delay_iface-day2-config.yml"
log_file_path = "/var/log/delay_iface.log"

f = open(day2_file_path, "r")
broker_ip_address = f.readline().split(":")[1].strip() + ":9092"                    # not used if Filebeat is provided
topic_name = f.readline().split(":")[1].strip()                                     # not used if Filebeat is provided
device_id = f.readline().split(":")[1].strip()
unit = f.readline().split(":")[1].strip()
interval = f.readline().split(":")[1].strip()
interval_value = int(re.compile('([0-9]+)([a-zA-Z]+)').match(interval).group(1))    # Each $interval_value time, metric will be captured
interval_unit = re.compile('([0-9]+)([a-zA-Z]+)').match(interval).group(2)
context = f.readline().split(":")[1].strip().replace("|", " ")                      # change "|" for " "

day2_file_path_2 = "/usr/bin/tracked_devices-day2-config.yml"
log_file_path_2 = "/var/log/tracked_devices.log"

f_2 = open(day2_file_path_2, "r")
broker_ip_address_2 = f_2.readline().split(":")[1].strip() + ":9092"                    # not used if Filebeat is provided
topic_name_2 = f_2.readline().split(":")[1].strip()                                     # not used if Filebeat is provided
device_id_2 = f_2.readline().split(":")[1].strip()
unit_2 = f_2.readline().split(":")[1].strip()
interval_2 = f_2.readline().split(":")[1].strip()
interval_value_2 = int(re.compile('([0-9]+)([a-zA-Z]+)').match(interval_2).group(1))    # Each $interval_value time, metric will be captured
interval_unit_2 = re.compile('([0-9]+)([a-zA-Z]+)').match(interval_2).group(2)
context_2 = f_2.readline().split(":")[1].strip().replace("|", " ")                      # change "|" for " "


day2_file_path_3 = "/usr/bin/apache_latency-day2-config.yml"
log_file_path_3 = "/var/log/apache_latency.log"

f_3 = open(day2_file_path_3, "r")
broker_ip_address_3 = f_3.readline().split(":")[1].strip() + ":9092"                    # not used if Filebeat is provided
topic_name_3 = f_3.readline().split(":")[1].strip()                                     # not used if Filebeat is provided
device_id_3 = f_3.readline().split(":")[1].strip()
unit_3 = f_3.readline().split(":")[1].strip()
interval_3 = f_3.readline().split(":")[1].strip()
interval_value_3 = int(re.compile('([0-9]+)([a-zA-Z]+)').match(interval_3).group(1))    # Each $interval_value time, metric will be captured
interval_unit_3 = re.compile('([0-9]+)([a-zA-Z]+)').match(interval_3).group(2)
context_3 = f_3.readline().split(":")[1].strip().replace("|", " ")                      # change "|" for " "



# Transform the interval_value consequently
if interval_unit == "s":
    interval_value = interval_value/1;
elif interval_unit == "ms":
    interval_value = interval_value/1000;

# Transform the interval_value consequently
if interval_unit_2 == "s":
    interval_value_2 = interval_value_2/1;
elif interval_unit_2 == "ms":
    interval_value_2 = interval_value_2/1000;

# Transform the interval_value consequently
if interval_unit_3 == "s":
    interval_value_3 = interval_value_3/1;
elif interval_unit_3 == "ms":
    interval_value_3 = interval_value_3/1000;




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

    metric_value_2 = random.uniform(-2,2)
    with open(log_file_path_2, 'a', newline='') as csvfile_2:
        writer_2 = csv.writer(csvfile_2, delimiter=',') #, quotechar='|', quoting=csv.QUOTE_MINIMAL)
        writer_2.writerow([metric_value_2, timestamp, unit_2, device_id_2, context_2])

    metric_value_3 = random.uniform(-2,2)
    with open(log_file_path_3, 'a', newline='') as csvfile_3:
        writer_3 = csv.writer(csvfile_3, delimiter=',') #, quotechar='|', quoting=csv.QUOTE_MINIMAL)
        writer_3.writerow([metric_value_3, timestamp, unit_3, device_id_3, context_3])



    time.sleep(interval_value)

print("Script finished")
