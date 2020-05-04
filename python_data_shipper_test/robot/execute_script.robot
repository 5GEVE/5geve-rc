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
${RC_SCRIPT_LOCATION}       /home/user/5geve-rc/python_data_shipper_test/ansible

# Variables related to the server to be configured
# All parameters from the probe should be provided by MS-NSO
# The password can be omitted if public key is exchanged beforehand
# The device ID must be provided by the MS-NSO or customized in the TCB

${PROBE_MGMT_ADDRESS}       10.9.8.205
${PROBE_USERNAME}           user
${PROBE_PASSWORD}           root

# Variables related to the experiment execution

${SUDO}                     true
${SHEBANG}                  /usr/bin/python3
${SCRIPT}                   /home/${PROBE_USERNAME}/metric_generator.py

# Variables related to the RF execution, composed from previous variables

${BUILD_HOSTS_FILE}         cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "server ansible_host=${PROBE_MGMT_ADDRESS} ansible_user=${PROBE_USERNAME} ansible_ssh_pass=${PROBE_PASSWORD} ansible_become_pass=${PROBE_PASSWORD}" | tee -a hosts > /dev/null
${RUN_SCRIPT}               cd ${RC_SCRIPT_LOCATION}; touch ansible_output; export ANSIBLE_HOST_KEY_CHECKING=False; /usr/bin/ansible-playbook -i hosts execute_script.yml -e "sudo=${SUDO} shebang=${SHEBANG} script=${SCRIPT}" > ansible_output

*** Test Cases ***
Launch script at RC to execute the experiment
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
