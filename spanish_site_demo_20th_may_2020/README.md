# 

This script performs the Day-2 configuration process in a specific VNF used during the Spanish Site demo on 20th May 2020, providing the information model to be used for publishing data from three different metrics in Kafka afterwards and also installing Filebeat with the necessary configuration to work properly. Then, a Python script is executed for each metric during the experiment execution process, in which data from the information model is read in order to properly generate the CSV rows to be saved in the files monitored by Filebeat, then the data is published in Kafka in the JSON format proposed in the information model defined. For that purpose, a simple Ansible playbook that executes the script provided is used.

In order to test it:

```sh
# 1. Make sure you download this repository in both Robot Framework (EEM) and Runtime Configurator servers.
cd $HOME
git clone git@github.com:5GEVE/5geve-rc.git

# 2. Go to the robot folder and generate the Robot Framework scripts to be used. Before doing this, please check that all the variables defined in each robot.tpl files are correct for your deployment.
cd $HOME/5geve-rc/spanish_site_demo_20th_may_2020/robot
chmod +x create_scripts.sh
./create_scripts.sh {VNF_IP_ADDRESS} {USER_EQUIPMENTS_TOPIC} {DELAY_IFACE_TOPIC} {APACHE_LATENCY_TOPIC}
# Example: ./create.sh 10.20.5.50 apache.14.spain_5tonic.application_metric.user_equipments apache.14.spain_5tonic.application_metric.delay_iface apache.14.spain_5tonic.infrastructure_metric.apache_latency

# 3. Execute the Robot Framework scripts related to the Day-2 configuration of each metric.
robot equipments.robot
robot delay.robot
robot apache.robot

# 4. Execute the Robot Framework script related to the experiment execution.
robot execute_script.robot
```
