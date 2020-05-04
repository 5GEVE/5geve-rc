# delay

This script executes a ping between two VNFs, extracting the RTT, which results in the delay measurement. Previously, it allows to execute a Day-2 configuration process in which Filebeat is installed in the monitored VNF. During the experiment execution, the results are saved in the file monitored by Filebeat, then the data is sent to Kafka. It does not follow the information model proposed in 5G EVE.

In order to test it:

```sh
# 1. Make sure you download this repository in both Robot Framework (EEM) and Runtime Configurator servers.
git clone git@github.com:5GEVE/5geve-rc.git

# 2. Modify the variables defined in measureDelayConfig.robot and in measureDelay.robot to fit in your scenario.

# 3. Execute the Robot Framework script related to the Day-2 configuration.
robot measureDelayConfig.robot

# 4. Execute the Robot Framework script related to the experiment execution.
robot measureDelay.robot
```
