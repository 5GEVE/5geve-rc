# 5geve-rc

Documentation, code and related tests for Ansible playbooks to be used in the Runtime Configurator component from the Interworking Layer.

Installation requirements:

```sh
# Ansible installation (in RC server)
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
export ANSIBLE_HOST_KEY_CHECKING=False

# Robot Framework installation (in EEM server, if needed)
pip install robotframework
pip install robotframework-sshlibrary
```

The way of executing each test is included in the different folders related to each one.

The scripts provided in this repository are:

| Name | Description |
| --- | --- |
| delay | Delay measurement, with Day-2 configuration, but not using the information model |
| execute_command | It executes a script provided as an argument in a Linux server. This playbook is integrated with the current RC release |
| execute_command_windows | It executes a script provided as an argument in a Windows server. This playbook is integrated with the current RC release |
| filebeat_data_shipper_test | Publish dummy data in Kafka by using Filebeat, which translates CSV data to JSON, using Day-2 configuration and the information model proposed. It monitors two different metrics in the same Filebeat service |
| hello_world | Only prints Hello World |
| hello_world_param | Prints Hello World + a parameter |
| install_filebeat | Similar playbook than the filebeat_data_shipper_test one, but adapted to the current RC release |
| python_data_shipper_test | Publish dummy data in Kafka by using Python, directly using a JSON chain, using Day-2 configuration and the information model proposed. Only one metric is monitored |
| spanish_site_demo_20th_may_2020 | Scripts for the demo executed in the Spanish site the 20th May 2020 |

The location of this repository in the RC component must be the following: /usr/bin/rc

## Copyright

This work has been done by Telcaria Ideas S.L. for the 5G EVE European project under the [Apache 2.0 License](LICENSE).
