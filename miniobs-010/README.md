# MINIOBS

MINIOBS-002 is an elastic stack consisting of elasticsearch and kibana. MINIOBS-002 has the trial license and the basic security features enabled. So all paid features are activated (Machine Learning, Watcher etc ...). 


PREREQUISITES
---
For running the MINIOBS stack you should order an 'EntwicklerVM' with the following performance:

Name           | Amount        
-------------- | --------------- 
CPU            | 4x
MEMORY         | 16384 (MB)
STORAGE        | 40 (GB)

Run the Stack
---

Run the miniobs-002 stack

1. To run miniobs-002 you have to go to the cloned 'miniobs-002' directory

        $ cd ~/miniobs-ws01/miniobs/miniobs-002
        $ docker-compose up

2. Use Kibana for further actions

        Login Credentials:
        User: elastic
        Password: changeme

        http://`<myhost>`:5601/

        Note: 'myhost' is your flt* host.

3. Use Elasticsearch from Remote

        curl -u elastic:changeme -XGET http://`<myhost>`:9200

4. Stop miniobs-002

        $ docker-compose stop

5. Start the miniobs-002 stack

        $ docker-compose start

6. Remove the entire miniobs-002 stack

        $ docker-compose down -v

Contributing
---
If you find some bugs or have any requests/suggestions don't hesitate to open an issue or make a pull request.
