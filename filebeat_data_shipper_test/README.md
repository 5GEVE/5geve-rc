# filebeat_data_shipper_test

This script performs the Day-2 configuration process in a specific VNF, providing the information model to be used for publishing in Kafka afterwards and also installing Filebeat with the necessary configuration to work properly. Then, a Python script is executed during the experiment execution process, in which data from the information model is read in order to properly generate the CSV rows to be saved in the file monitored by Filebeat, then the data is published in Kafka in the JSON format proposed in the information model defined. For that purpose, a simple Ansible playbook that executes the script provided is used.

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
