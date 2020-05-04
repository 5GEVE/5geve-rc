# python_data_shipper_test

This script performs the Day-2 configuration process in a specific VNF, providing the information model to be used for publishing in Kafka afterwards. Then, a Python script is executed during the experiment execution process, in which data from the information model is read in order to properly generate the JSON chain to be directly sent to Kafka by using the Kafka library implemented in Python, so the Data shipper is the Python script itself. Note that the Ansible playbooks and Robot Framework scripts are practically the same than in filebeat_data_shipper_test module, but changing simple=yes in day2-config.yml in order not to install Filebeat. In fact, filebeat.yml file is not needed in this test, but it is maintained for showing that the Robot Framework and Ansible scripts do not need to change at all in case of using one or another Data shipper implementation.

In order to test it:

```sh
# 1. Make sure you download this repository in both Robot Framework (EEM) and Runtime Configurator servers.
git clone git@github.com:5GEVE/5geve-rc.git

# 2. Make sure that the script auxiliary_scripts/metric_generator.py is placed in the VNF. In a real case, it would be code developed by any of the actors involved in the 5G EVE workflow.

# 3. Also, make sure to execute the following commands in the VNF for being able to execute the Python script.
sudo apt install python3-pip
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales
pip3 install kafka

# 4. Modify the variables defined in day2-config.robot and in execute_script.robot to fit in your scenario.

# 5. Execute the Robot Framework script related to the Day-2 configuration.
robot day2-config.robot

# 6. Execute the Robot Framework script related to the experiment execution.
robot execute_script.robot