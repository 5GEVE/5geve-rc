*** Settings ***
Suite Teardown    Close All Connections
Library           SSHLibrary
Library           String
Library           Collections
Library           BuiltIn

*** Variables ***
# Variables related to the RC
# All four RC parameters are static, so we might think about storing them in EEM, and retrieving them during script execution time
${RC_MGMT_ADDRESS}          10.9.8.204     #rc.server.mgmt_address
${RC_USERNAME}              user     #rc.server.username
${RC_PASSWORD}              root     #rc.server.password
${RC_SCRIPT_LOCATION}       /home/user/5geve-rc/day2_config_filebeat_data_shipper/ansible     #rc.server.scripts.location

# Variables related to the Kafka broker
${BROKER_IP_ADDRESS}        10.9.8.203     #broker.address     # Static parameter
${TOPIC_NAME}               4.france_nice.infrastructure_metric.expb_metricId     #broker.topic     #This comes from ELM

# Variables related to the server to be configured
${PROBE_MGMT_ADDRESS}       10.9.8.205     #probe.mgmt.address     #All parameters from the probe should be provided by MS-NSO
${PROBE_USERNAME}           user     #probe.username
${PROBE_PASSWORD}           root     #probe.password     # Can be omitted if public key is exchanged
${DEVICE_ID}                5geve-vnf1     #probe.deviceid     # To be provided by the MS-NSO or customized in the TCB

# Variables related to the metrics to be captured
${UNIT}                     expb_metricName     #metric.unit
${INTERVAL}                 5s     #metric.interval

# Variables related to context conditions (optional)
${CONTEXT}                  "param1=value1 param2=value2"

# Variables related to the RF execution, composed from previous variables
${MONITORED_FILE_PATH}      /var/log/${TOPIC_NAME}.log     #monitored.path
${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "server ansible_host=${PROBE_MGMT_ADDRESS} ansible_user=${PROBE_USERNAME} ansible_ssh_pass=${PROBE_PASSWORD} ansible_become_pass=${PROBE_PASSWORD} device_id=${DEVICE_ID}" | tee -a hosts > /dev/null     #hosts.file.exec
${RUN_SCRIPT}               cd ${RC_SCRIPT_LOCATION}; touch ansible_config_log; ansible-playbook -i hosts day2-config.yml -e "broker_ip_address=${BROKER_IP_ADDRESS} topic_name=${TOPIC_NAME} unit=${UNIT} interval=${INTERVAL} context=${CONTEXT} monitored_file_path=${MONITORED_FILE_PATH}" > ansible_config_log     #script.exec

*** Test Cases ***
Launch script at RC to configure the probes required in method "measureDelay"
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
