# elasticsearch-docker-composer-for-liferay-7
This is for setting up docker-composer to test Elasticsearch and Kuromoji against Liferay 7 GA4 / DXP de30 (Elasticsearch 2.4)

## Required environment
- Docker 17.06.2-ce >=
- Java8

## How to set up
1. Clone this repository
2. Go to /es/config/elasticsearch.yml and configure network.publish_host to the address where this docker images run. If it's your local machine, should be "192.168.1.4" e.g.
3. Go back to the root folder and run ```docker-compose up --build```
4. Start Liferay DXP / 7
5. Login as an administrator and navigate to Control Panel -> Configuration -> System Setting -> Basic configuration tab -> Elasticsearch
6. Change Operation mode to REMOTE and Transport addresses to your IP, something like "192.168.1.4:9300"
7. Click save and restart Liferay server
8. Loging as an administrator, navigate to Control Panel -> Configuration -> Server Configuration and run reindex.

## Initialize set up after change configurations
1. Stop services with ```docker-compose stop```
2. Run ```docker rm -f `docker ps -qa` ```
3. Run ```docker rmi `docker images | sed -ne '2,$p' -e 's/ */ /g' | awk '{print $1":"$2}'` ```

## How to access elasticsearch and tools
### Elasticsearch
```http://localhost:9200```

### Sense (Analyzing tool for Elasticsearch)
```http://localhost:5601/app/sense```

### Elastic-HQ
```http://localhost:9200/_plugin/hq```