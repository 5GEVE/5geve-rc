*** Settings ***
Suite Teardown    Close All Connections
Library           SSHLibrary
Library           String
Library           Collections
Library           BuiltIn

*** Variables ***
# Variables related to the RC
# All four RC parameters are static, so we might think about storing them in EEM, and retrieving them during script execution time

${RC_MGMT_ADDRESS}          127.0.0.1
${RC_USERNAME}              ramon
${RC_PASSWORD}              iW1L.27!
${RC_SCRIPT_LOCATION}       /home/ramon/${RC_USERNAME}/spanish_site_demo_20th_may_2020/ansible

# Variables related to the Kafka broker
# Broker IP address is a static parameter, but topic name must come from ELM

${BROKER_IP_ADDRESS}        10.3.5.100
${TOPIC_NAME}               TOPICNAME

# Variables related to the server to be configured
# All parameters from the probe should be provided by MS-NSO
# The password can be omitted if public key is exchanged beforehand
# The device ID must be provided by the MS-NSO or customized in the TCB

${PROBE_MGMT_ADDRESS}       IPADDR
${PROBE_USERNAME}           ubuntu
${PROBE_PASSWORD}           ubuntu
${DEVICE_ID}                5geve-vnf

# Variables related to the metrics to be captured
# This information is directly copied from the blueprints and can be provided by the ELM

${METRIC_ID}                user_equipments
${UNIT}                     devices
${INTERVAL}                 5s

# Variables related to context conditions (optional)
# Context can be defined in the TCB. They must be provided in that way

${CONTEXT}                  param1=value1

# Variables related to the RF execution, composed from previous variables

${MONITORED_FILE_PATH}      /var/log/${METRIC_ID}.log
${SIMPLE}                   no
${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "server ansible_host=${PROBE_MGMT_ADDRESS} ansible_user=${PROBE_USERNAME} ansible_ssh_pass=${PROBE_PASSWORD} ansible_become_pass=${PROBE_PASSWORD} device_id=${DEVICE_ID}" | tee -a hosts > /dev/null
${RUN_SCRIPT}               cd ${RC_SCRIPT_LOCATION}; touch ansible_config_log_2; export ANSIBLE_HOST_KEY_CHECKING=False; /usr/bin/ansible-playbook -i hosts day2-config.yml -e "broker_ip_address=${BROKER_IP_ADDRESS} topic_name=${TOPIC_NAME} metric_id=${METRIC_ID} unit=${UNIT} interval=${INTERVAL} context=${CONTEXT} monitored_file_path=${MONITORED_FILE_PATH} simple=${SIMPLE}" > ansible_config_log_2

*** Test Cases ***
Launch script at RC to apply the Day-2 Configuration in probes
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
