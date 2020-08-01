# Receipe 115 - Alerting feature

miniobs v7.8.1 contains various elastic stack use cases based on elastiv v7.8.1 for demo or learning purposes.


SETUP
---

1. Clone the miniobs repo ( => if it's already done - skip this point!)

        $ cd ~
        $ mkdir miniobs-ws01
        $ cd miniobs-ws01
        $ git clone https://github.com/prosmc/miniobs.git

2. Initial setup of your environment ( => if it's already done - skip this point!)

        $ cd miniobs
        $ source ./.envrc
        $ x_setup

    **NOTE:** x_setup modifies Kernel parameter and reboots your host system after 30 seconds\
    due to the modifications of the kernel parameter.
      
3.1 Choose the use cases miniobs-115 and generate the ssl-certificate which is needed for running\
   Kibana in a secure mode so that the alerting can be enabled.

        $ cd ~/miniobs/miniobs-115
        $ docker-compose -f create-certs.yml run --rm create_certs

3.2 After the ssl-cert & ssl-key is generated you can start the elastic stack

        $ docker-compose up -d 

    **NOTE:** instead of running the commands in 3.1 & 3.2 step-by-step you can source the .envrc 
    file for running the function x_inst

        $ . ./.envrc
        $ x_inst

4. Use Kibana for further actions

        https://<hostname>:5601

        user: elastic
        password: changeme

   ![Kibana Login](resources/assets/images/miniobs-115_pict-01.png)

5. Stop the docker containers

        $ docker-compose stop

6. Start the docker containers

        $ docker-compose start  

5. Remove the docker containers

        $ docker-compose down -v

CONTRIBUTING
---
If you find some bugs or have any requests/suggestions don't hesitate to open an issue or make a pull request.
