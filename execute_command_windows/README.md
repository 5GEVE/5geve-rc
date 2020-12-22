# execute_command_windows

This playbook directly executes a script provided as an argument in the targeted Windows server. This playbook is already integrated in the current RC release, so it does not have tests in Robot Framework.

Arguments to be provided to the playbook (apart from *ansible_host, ansible_user* and *ansible_password*, provided in the hosts file):

* *script* - complete script to be executed in the targeted server

The instructions related to this playbook must be defined in this way:

**EXECUTE_COMMAND_WINDOWS <SERVER_IP_ADDRESS> <USERNAME>:<PASSWORD> *script*;**

Example of how to define operations related to this playbook in the TCBs:

**EXECUTE_COMMAND_WINDOWS vnf.<vnfdA_id>.extcp.<extcp_id>.ipaddress $$userA:$$passwordA ping www.google.es;**

Remember that the IP address must be referenced in the infrastructureParameters field, and that the user and password must be defined in the userParameters field.
