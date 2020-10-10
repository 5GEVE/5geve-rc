# python_data_shipper_test

This script performs the Day-2 configuration process in a specific VNF, providing the information model to be used for publishing in Kafka afterwards. Then, a Python script is executed during the experiment execution process, in which data from the information model is read in order to properly generate the JSON chain to be directly sent to Kafka by using the Kafka library implemented in Python, so the Data shipper is the Python script itself. Note that the Ansible playbooks and Robot Framework scripts are practically the same than in filebeat_data_shipper_test module, but changing simple=yes in day2-config.robot in order not to install Filebeat, and including the installation of the Kafka library via pip3 in day2-config.yml. In fact, filebeat.yml file is not needed in this test, but it is maintained for showing that the Robot Framework and Ansible scripts do not need to change at all in case of using one or another Data shipper implementation.

In order to test it:

```sh
# 1. Make sure you download this repository in both Robot Framework (EEM) and Runtime Configurator servers.
git clone git@github.com:5GEVE/5geve-rc.git

# 2. Make sure that the script auxiliary_scripts/metric_generator.py is placed in the VNF. In a real case, it would be code developed by any of the actors involved in the 5G EVE workflow.

# 3. Modify the variables defined in day2-config.robot and in execute_script.robot to fit in your scenario.

# 4. Execute the Robot Framework script related to the Day-2 configuration.
robot day2-config.robot

# 5. Execute the Robot Framework script related to the experiment execution.
robot execute_script.robot
```

## Metric Data Model

- `metric_value` is a float or integer value
- `timestamp` is a 10-digit float or integer value (unix epoch)
- `unit` is any string representing the unit of the measurement
- `device_id` is any string identifying the device generating the metric
- `context` contains the context parameters (empty here)

### CSV example

```
metric_value,timestamp,unit,device_id,context
5.47,1602349170.00,%,localhost.localdomain,
```

### JSON example

```json
records: [
  {
    "value": {
      "context": {},
      "metric_value": 34.52,
      "timestamp": 1602348105.56,
      "unit": "%",
      "device_id": "localhost.localdomain"
    }
  }
]
```
