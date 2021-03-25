# miniobs-005 - Kickstarter

This recipe contains a very simple stack consisting of 1x elasticsearch and 1x kibana node. It's main purpose is to
to get up and running without any effort and as quick as possible.

This is made with Herblut/2021 - so please give us a [GitHub Star](https://github.com/prosmc/miniobs/stargazers)
if you like the project.\ Thank you in advance!


SETUP
---

01. Clone the miniobs repo ( => if it's already done - skip this point!)

        $ cd ~
        $ mkdir miniobs-ws01
        $ cd miniobs-ws01
        $ git clone https://github.com/prosmc/miniobs.git

02. Initial setup of your environment ( => if it's already done - skip this point!)

        $ cd miniobs
        $ source ./.xrc
        $ x_setup

    **NOTE:** x_setup modifies Kernel parameter and reboots your host system after 30 seconds\
    due to the modifications of the kernel parameter.
      
03. a) Choose the use cases miniobs-005 and generate the ssl-certificate which is needed for running\
   Kibana in a secure mode so that the 'Alerting' can be enabled.

        $ cd ~/miniobs/miniobs-005

    b) After the ssl-cert & ssl-key is generated you can start the elastic stack

        $ docker-compose up -d 

    **NOTE:** instead of running the commands in 3 a & 3 b step-by-step you can source the .envrc 
    file for running the function x_inst

        $ . ./.xrc
        $ x_setup

04. Log in to Kibana

        http://localhost:5601

        user: elastic
        password: changeme

   ![Kibana Login](resources/assets/images/miniobs-115_pict-01.png)


Stop and Start the elastic stack
---

05. Stop the docker containers

        $ docker-compose stop

06. Start the docker containers

        $ docker-compose start 

Remove the entire stack
---

07. Remove the docker containers

        $ docker-compose down -v

    **NOTE:** when you run 'docker-compose down -v' you'll loose all your data too.

CONTRIBUTING
---
If you find some bugs or have any requests/suggestions don't hesitate to open an issue or make a pull request.
