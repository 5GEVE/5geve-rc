# execute_command

This playbook directly executes a script provided as an argument in the targeted server. This playbook is already integrated in the current RC release, so it does not have tests in Robot Framework.

Arguments to be provided to the playbook (apart from *ansible_host, ansible_user, ansible_ssh_pass* and *ansible_become_pass*, provided in the hosts file):

* *script* - complete script to be executed in the targeted server

The instructions related to this playbook must be defined in this way:

** EXECUTE_COMMAND <SERVER_IP_ADDRESS> <USERNAME>:<PASSWORD> *script*; **

Example of how to define operations related to this playbook in the TCBs:

** EXECUTE_COMMAND vnf.<vnfdA_id>.extcp.<extcp_id>.ipaddress $$userA:$$passwordA "sudo apt-get install python3"; **

Remember that the IP address must be referenced in the infrastructureParameters field, and that the user and password must be defined in the userParameters field.
