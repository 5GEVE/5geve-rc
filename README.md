# 5geve-rc
Documentation, code and related tests for the Runtime Configurator component from the Interworking Layer.

Installation requirements:

```sh
# Ansible installation (in RC server)
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
export ANSIBLE_HOST_KEY_CHECKING=False

# Robot Framework installation (in EEM server)
pip install robotframework
pip install robotframework-sshlibrary
```

The way of executing each test is included in the different folders related to each one.
