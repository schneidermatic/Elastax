# stack-510

stack-510 is the entire elastic stack based on docker-compose. 

PREREQUISITES
---
For running the elastic-stack you need the following software components on your host system

Name           | Reference    
-------------- | --------------- 
docker         | [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
docker-compose | [https://docs.docker.com/compose/reference/overview/](https://docs.docker.com/compose/reference/overview/)

**IMPORTANT NOTE** <br>
Before you can run stack-510 successfully you have to change your system settings as it is described here:
[https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html)

For Ubuntu 18.04.x LTS (Bionic Beaver) there is a script ('./scripts/setup-prerequisites.sh') for modifying the system settings.

        $ sudo ./scripts/setup-prerequisites.sh

stack-510 Components
---
Component Name | Version         
-------------- | --------------
elasticsearch  | 7.15.0         
kibana         | 7.15.0         
logstash       | 7.15.0         
auditbeat      | 7.15.0           
filebeat       | 7.15.0          
heartbeat      | 7.15.0           
journalbeat    | 7.15.0          
metricbeat     | 7.15.0           
packetbeat     | 7.15.0           
apm-server     | 7.15.0           

Installation
---
elastic-stack is based on docker-compose. The following brief description shows how you can run elastic:

        $ mkdir ~/elastic-stack-ws01
        $ cd ./elastic-stack-ws01
        $ git clone https://github.com/prosmc/elastic-stack.git
        $ cd elastic-stack
        $ . ./.xrc
        $ x_inst

After a successfull installation the kibana console should be available under ...

        http://localhost:5601/

You can log in with the following credentials

User: elastic <br>
Password: changeme <br>

Show all commands
---
You can list the commands which are provided by elastic-stack with ...

       $ cmd

.xrc command overview
---
Command        | Description
-------------- | ---------------------------------
cmd            | Show all aliases which are defined in envrc
x_inst         | Install the entire miniobs Stack and start all components
x_uninst       | Stop all components and remove the entire miniobs stack
x_rm           | Remove all miniobs docker images

Contributing
---
If you find some bugs or have any requests/suggestions don't hesitate to open an issue or make a pull request.
