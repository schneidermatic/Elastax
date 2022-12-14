# stack-010 / Basic Architecture

This recipe contains an elastic stack consisting of 1x elasticsearch and 1x kibana node. stack-010 has the trial license 
and the basic security features enabled. So all license based features are activated (Machine Learning, Watcher etc ...) by
default.

![Elastic Stack Basic Architecture](../resources/assets/images/BasicArchitecture-01.png)

Please give us a [GitHub Star](https://github.com/schneidermatix/elastic-stax/stargazers)
if you like the project. Thank you in advance!

![Made with Herzblut](../resources/assets/images/MadeWithHerzblut01.png) <br>

###### PREREQUISITES
---
For running the stack-recipes(s) you need the following software components on your host system

Name           | Reference    
-------------- | --------------- 
ubuntu         | >= 18.04.5 LTS (Bionic Beaver)
docker         | [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
docker-compose | [https://docs.docker.com/compose/reference/overview/](https://docs.docker.com/compose/reference/overview/)

SETUP
---

01. Clone the stack repo ( => if it's already done - skip this point!)

        $ cd ~
        $ mkdir workspace
        $ cd workspace
        $ git clone https://github.com/schneidermatix/elastic-stax.git

02. Initial setup of your environment ( => if it's already done - skip this point!)

        $ cd elastic-stax
        $ source ./.xrc
        $ x_setup

    **NOTE:** x_setup modifies Kernel parameter and reboots your host system after 30 seconds\
    due to the modifications of the kernel parameter.

03. a) Go to the stack-010 folder

        $ cd ./stack-010

    b) Run the docker-compose command for starting the containers

        $ docker-compose up -d

    **NOTE:** The '.xrc' file contains some short-hand functions for an easier handling. So you\
    can run the 'x_up' command for starting the containers.

        $ source ./.xrc
        $ x_up

    A list of all 'x_*' short-hand commands you can get by running ...

        $ x_ls

04. Use Kibana for further actions

        Login Credentials:

        User: elastic
        Password: changeme

        http://localhost:5601/

    ![Kibana Login](../resources/assets/images/stack-010_pict-01.png)

05. Use the Elasticsearch REST-API via curl

        $ curl -u elastic:changeme -XGET http://localhost:9200

Stop and Start the elastic stack
---

06. Stop the docker containers

        $ docker-compose stop

07. Start the docker containers

        $ docker-compose start 

Remove the entire stack
---

07. Remove the docker containers

        $ docker-compose down -v

    **NOTE:** when you run 'docker-compose down -v' you'll loose all your data too.

Contributing
---
If you find some bugs or have any requests/suggestions don't hesitate to open an issue or make a pull request.
