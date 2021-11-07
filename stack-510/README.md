# miniobs

miniobs is the entire elastic stack based on docker-compose. miniobs is inspired by the idea of elastic-stack-docker (https://github.com/elastic/stack-docker.git).

PREREQUISITES
---
For running the miniobs stack you need the following software components on your host system

Name           | Reference    
-------------- | --------------- 
docker         | [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
docker-compose | [https://docs.docker.com/compose/reference/overview/](https://docs.docker.com/compose/reference/overview/)

**IMPORTANT NOTE** <br>
Before you can run miniobs successfully you have to change your system settings as it is described here:
[https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html)

For Ubuntu 18.04.x LTS (Bionic Beaver) there is a script ('./scripts/setup-prerequisites.sh') for modifying the system settings.

        $ sudo ./scripts/setup-prerequisites.sh

miniobs Stack Components
---
Component Name | Version         | Reference
-------------- | --------------- | --------------- 
elasticsearch  | 7.6.x           | [https://www.elastic.co/guide/en/elasticsearch/reference/7.6/index.html](https://www.elastic.co/guide/en/elasticsearch/reference/7.6/index.html)
kibana         | 7.6.x           | [https://www.elastic.co/guide/en/kibana/7.6/index.html](https://www.elastic.co/guide/en/kibana/7.6/index.html)
logstash       | 7.6.x           | [https://www.elastic.co/guide/en/logstash/7.6/index.html](https://www.elastic.co/guide/en/logstash/7.6/index.html)
auditbeat      | 7.6.x           | [https://www.elastic.co/guide/en/beats/auditbeat/7.6/index.html](https://www.elastic.co/guide/en/beats/auditbeat/7.6/index.html)
filebeat       | 7.6.x           | [https://www.elastic.co/guide/en/beats/filebeat/7.6/index.html](https://www.elastic.co/guide/en/beats/filebeat/7.6/index.html)
heartbeat      | 7.6.x           | [https://www.elastic.co/guide/en/beats/heartbeat/7.6/index.html](https://www.elastic.co/guide/en/beats/heartbeat/7.6/index.html)
journalbeat    | 7.6.x           | [https://www.elastic.co/guide/en/beats/journalbeat/7.6/index.html](https://www.elastic.co/guide/en/beats/journalbeat/7.6/index.html)
metricbeat     | 7.6.x           | [https://www.elastic.co/guide/en/beats/metricbeat/7.6/index.html](https://www.elastic.co/guide/en/beats/metricbeat/7.6/index.html)
packetbeat     | 7.6.x           | [https://www.elastic.co/guide/en/beats/packetbeat/7.6/index.html](https://www.elastic.co/guide/en/beats/packetbeat/7.6/index.html)
apm-server     | 7.6.x           | [https://www.elastic.co/guide/en/beats/apm-server/7.6/index.html](https://www.elastic.co/guide/en/beats/apm-server/7.6/index.html)

Installation
---
miniobs is based on docker-compose. The following brief description shows how you can run miniobs:

        $ cd ~
        $ git clone https://github.com/prosmc/miniobs.git
        $ cd miniobs
        $ git checkout <branch> # 'master' or i. e. 'miniobs-7.6.1'
        $ . ./.envrc
        $ x_inst

After a successfull installation the kibana console should be available under ...

        http://localhost:5601/

You can log in with the following credentials

User: elastic <br>
Password: changeme <br>

Show all commands
---
You can list the commands which are provided by miniobs with ...

       $ cmd

miniobs command overview
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
