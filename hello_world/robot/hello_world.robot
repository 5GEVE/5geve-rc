*** Settings ***
Suite Teardown    Close All Connections
Library           SSHLibrary
Library           String
Library           Collections
Library           BuiltIn

*** Variables ***
${RC_MGMT_ADDRESS}    		10.9.8.204 #rc.server.mgmt_address    #All four RC parameters are static, so we might think about storing them in EEM, and retrieving them during script execution time
${RC_USERNAME}        		user #rc.server.username
${RC_PASSWORD}    		root #rc.server.password
${RC_SCRIPT_LOCATION}    	/home/user/5geve-rc/hello_world/ansible #rc.server.scripts.location
${SRC_PROBE_MGMT_ADDRESS}    	10.9.8.204 #probe1.mgmt.address    #All parameters from the probes should be provided by MS-NSO
${SRC_PROBE_USERNAME}    	user #probe1.username
${SRC_PROBE_PASSWORD}    	root #probe1.password
${BUILD_HOSTS_FILE}    cd ${RC_SCRIPT_LOCATION}; touch hosts; echo "src_server ansible_host=${SRC_PROBE_MGMT_ADDRESS} ansible_user=${SRC_PROBE_USERNAME} ansible_ssh_pass=${SRC_PROBE_PASSWORD}" | tee -a hosts > /dev/null
${RUN_SCRIPT}     cd ${RC_SCRIPT_LOCATION}; touch ansible_output; ansible-playbook -i hosts hello_world.yml > ansible_output

*** Test Cases ***
Launch script at RC to measure two-way delay between two probes
    Open Connection to Runtime Configurator and Log In
    Execute Command    ${BUILD_HOSTS_FILE}
    Execute Command    ${RUN_SCRIPT}

*** Keywords ***
Open Connection to Runtime Configurator and Log In
    Open Connection    ${RC_MGMT_ADDRESS}
    Login    ${RC_USERNAME}    ${RC_PASSWORD}
