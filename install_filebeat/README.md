# install_filebeat

This playbook performs the Day-2 configuration process in a specific VNF, providing the information model to be used for publishing data in Kafka for the metric provided as argument (saved, by default, in the file /usr/bin/<metric_id>-day2-config.yml, where *metric_id* is one of the parameters provided in the TCB as argument), and also installing Filebeat with the necessary configuration to work properly. 

Note that this playbook does not include the generation of metrics' values during the experiment execution process, in which data from the information model is read in order to properly generate the CSV rows to be saved in the files monitored by Filebeat, and then the data is published in Kafka in the JSON format proposed in the information model defined. An example of these kind of logic can be found in the filebeat_data_shipper_test playbook.

This playbook is already integrated in the current RC release, so it does not have tests in Robot Framework.

Arguments to be provided to the playbook (apart from *ansible_host, ansible_user, ansible_ssh_pass* and *ansible_become_pass*, provided in the hosts file):

* *metric_id* - metricId, directly copied from the blueprint where it has been defined
* *topic_name* - reference to the topic name, to be translated by the EEM
* *site* - reference to the site facility, to be translated by the EEM
* *unit* - reference to the metric unit, to be translated by the EEM
* *interval* - reference to the metric interval, to be translated by the EEM
* *device_id* - reference to the deviceId, to be translated by the EEM, or it can be also provided as userParameter in the TCB. If not used, please set it to nil
* *monitored_file_path* - file path to be monitored by Filebeat. By default, it should be /var/log/<metric_id>.log. The script/command/logic/whatever that generates the metrics' value must save the data in that file in CSV format. The exact format can be reviewed in D3.4, section 3.4.3.3.

The instructions related to this playbook must be defined in this way:

** INSTALL_FILEBEAT <SERVER_IP_ADDRESS> <USERNAME>:<PASSWORD> *metric_id topic_name site unit interval device_id monitored_file_path*; **

Example of how to define operations related to this playbook in the TCBs:

** INSTALL_FILEBEAT vnf.<vnfdA_id>.extcp.<extcp_id>.ipaddress $$userA:$$passwordA track_device $metric.topic.track_device $$metric.site.track_device $$metric.unit.track_device $$metric.interval.track_device $$metric.deviceId.track_device $$monitoredPath1; **

Remember that the IP address and all the references to the corresponding metric must be referenced in the infrastructureParameters field, and that the user, password and monitored path must be defined in the userParameters field.
