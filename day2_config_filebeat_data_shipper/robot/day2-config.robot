*** Settings ***
Suite Teardown    Close All Connections
Library           SSHLibrary
Library           String
Library           Collections
Library           BuiltIn

*** Variables ***
# Variables related to the RC
# All four RC parameters are static, so we might think about storing them in EEM, and retrieving them during script execution time

${RC_MGMT_ADDRESS}          10.9.8.204
${RC_USERNAME}              user
${RC_PASSWORD}              root
${RC_SCRIPT_LOCATION}       /home/user/5geve-rc/day2_config_filebeat_data_shipper/ansible

# Variables related to the Kafka broker
# Broker IP address is a static parameter, but topic name must come from ELM

${BROKER_IP_ADDRESS}        10.9.8.203
${TOPIC_NAME}               4.france_nice.infrastructure_metric.expb_metricId

# Variables related to the server to be configured
# All parameters from the probe should be provided by MS-NSO
# The password can be omitted if public key is exchanged beforehand
# The device ID must be provided by the MS-NSO or customized in the TCB

${PROBE_MGMT_ADDRESS}       10.9.8.205
${PROBE_USERNAME}           user
${PROBE_PASSWORD}           root
${DEVICE_ID}                5geve-vnf1

# Variables related to the metrics to be captured
# This information is directly copied from the blueprints and can be provided by the ELM

${METRIC_ID}                expb_metricId
${UNIT}                     expb_metricUnit
${INTERVAL}                 5s

# Variables related to context conditions (optional)
# Context can be defined in the TCB. They must be provided in that way

${CONTEXT}                  param1=value1|param2=value2

# Variables related to the RF execution, composed from previous variables

${MONITORED_FILE_PATH}      /var/log/${METRIC_ID}.log
${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "server ansible_host=${PROBE_MGMT_ADDRESS} ansible_user=${PROBE_USERNAME} ansible_ssh_pass=${PROBE_PASSWORD} ansible_become_pass=${PROBE_PASSWORD} device_id=${DEVICE_ID}" | tee -a hosts > /dev/null
${RUN_SCRIPT}               cd ${RC_SCRIPT_LOCATION}; touch ansible_config_log; export ANSIBLE_HOST_KEY_CHECKING=False; /usr/bin/ansible-playbook -i hosts day2-config.yml -e "broker_ip_address=${BROKER_IP_ADDRESS} topic_name=${TOPIC_NAME} metric_id=${METRIC_ID} unit=${UNIT} interval=${INTERVAL} context=${CONTEXT} monitored_file_path=${MONITORED_FILE_PATH}" > ansible_config_log

*** Test Cases ***
Launch script at RC to apply the Day-2 Configuration in probes
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
