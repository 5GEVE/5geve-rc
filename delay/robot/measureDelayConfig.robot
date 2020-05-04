*** Settings ***
Suite Teardown    Close All Connections
Library           SSHLibrary
Library           String
Library           Collections
Library           BuiltIn

*** Variables ***
#All four RC parameters are static, so we might think about storing them in EEM, and retrieving them during script execution time

${RC_MGMT_ADDRESS}          10.9.8.204 
${RC_USERNAME}              user
${RC_PASSWORD}              root
${RC_SCRIPT_LOCATION}       /home/user/5geve-rc/delay/ansible

#All parameters from the probe should be provided by MS-NSO

${SRC_PROBE_MGMT_ADDRESS}   10.9.8.205
${SRC_PROBE_USERNAME}       user
${SRC_PROBE_PASSWORD}       root

#This comes from ELM

${KAFKA_TOPIC}              topictest

#Fixed parameter

${KAFKA_IP_ADDRESS}         10.9.8.203

#Other parameters

${MONITORED_FILE_PATH}      /home/user/src_ping
${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "src_server ansible_host=${SRC_PROBE_MGMT_ADDRESS} ansible_user=${SRC_PROBE_USERNAME} ansible_ssh_pass=${SRC_PROBE_PASSWORD} ansible_become_pass=${SRC_PROBE_PASSWORD}" | tee -a hosts > /dev/null
${RUN_SCRIPT}               cd ${RC_SCRIPT_LOCATION}; touch ansible_config_log; ansible-playbook -i hosts measureDelayConfig.yml -e "kafka_topic=${KAFKA_TOPIC} kafka_ip_address=${KAFKA_IP_ADDRESS} monitored_file_path=${MONITORED_FILE_PATH}" > ansible_config_log

*** Test Cases ***
Launch script at RC to configure the probes required in method "measureDelay"
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
