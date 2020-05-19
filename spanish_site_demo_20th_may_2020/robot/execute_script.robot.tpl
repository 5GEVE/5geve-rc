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
${RC_SCRIPT_LOCATION}       /home/${RC_USERNAME}/5geve-rc/spanish_site_demo_20th_may_2020/ansible

# Variables related to the server to be configured
# All parameters from the probe should be provided by MS-NSO
# The password can be omitted if public key is exchanged beforehand
# The device ID must be provided by the MS-NSO or customized in the TCB

${PROBE_MGMT_ADDRESS}       IPADDR
${PROBE_USERNAME}           ubuntu
${PROBE_PASSWORD}           ubuntu

# Variables related to the experiment execution

${SUDO}                     true
${SHEBANG}                  /usr/bin/python3
${SCRIPT_1}                 /home/${PROBE_USERNAME}/metric_generator.py

# Variables related to the RF execution, composed from previous variables

${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "server ansible_host=${PROBE_MGMT_ADDRESS} ansible_user=${PROBE_USERNAME} ansible_ssh_pass=${PROBE_PASSWORD} ansible_become_pass=${PROBE_PASSWORD}" | tee -a hosts > /dev/null
${RUN_SCRIPT_1}             cd ${RC_SCRIPT_LOCATION}; touch ansible_output_1; export ANSIBLE_HOST_KEY_CHECKING=False; /usr/bin/ansible-playbook -i hosts execute_script.yml -e "sudo=${SUDO} shebang=${SHEBANG} script=${SCRIPT_1}" > ansible_output_1

*** Test Cases ***
Launch script at RC to execute the experiment
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT_1}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
