# elasticsearch-docker-composer-for-liferay-7
This is for setting up docker-composer to test Elasticsearch and Kuromoji against Liferay 7 GA6 / DXP de42 (Elasticsearch 6.1.3). **The JDK type (OpenJDK / OracleJDK) need to match between Elasticsearch and Liferay because Liferay using binary protocol to communicate with Elasticsearch. Master is ```Oracle jdk8``` version. If you are looking for ```${elasticsearch_version}_openjdk8``` version, please refer ```${elasticsearch_version}_openjdk8``` branch of this repository.**

If you are using lower than Liferay 7 GA6 / DXP de42, please use branch ```2.4_openjdk8``` or ```2.4_oraclejdk8``` depending on what version of JDK type (OpenJDK / OracleJDK) using for Liferay.

## Required environment
- Docker 17.06.2-ce >=
- Java8 (Oracle JDK 8 or Open JDK 8)

## How to set up (Oracle JDK, master branch)
1. Clone this repository
2. Change the file permission of ```/es/docker-entrypoint.sh``` to executable.
3. Go back to the root folder and run ```docker-compose up --build``` or just ```docker-compose up```
4. Start Liferay DXP / 7
5. Login as an administrator and navigate to Control Panel -> Configuration -> System Setting -> Basic configuration tab -> Elasticsearch
6. Change Operation mode to REMOTE and Transport addresses to your IP according to the console log, '''publish_address {127.0.0.1:9300}'''. In this case, the Transport address should be ```"127.0.0.1:9300"```
7. Click save and restart Liferay server
8. Loging as an administrator, navigate to Control Panel -> Configuration -> Server Configuration and run reindex.

## How to set up (Open JDK, openjdk8 branch)
1. Clone this repository
2. Go back to the root folder and run ```docker-compose up --build``` or just ```docker-compose up```
3. Start Liferay DXP / 7
4. Login as an administrator and navigate to Control Panel -> Configuration -> System Setting -> Basic configuration tab -> Elasticsearch
5. Change Operation mode to REMOTE and Transport addresses to your IP according to the console log, '''publish_address {127.0.0.1:9300}'''. In this case, the Transport address should be ```"127.0.0.1:9300"```
6. Click save and restart Liferay server
7. Loging as an administrator, navigate to Control Panel -> Configuration -> Server Configuration and run reindex.

## Modify user dictionaly
1. Open /es/config/userdict_ja.txt
2. Modify contents according to the [user guide](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji-tokenizer.html)
## Initialize set up after change configurations
1. Stop services with ```docker-compose stop```
2. Delete folders under ```/es/data```
3. Run ```docker rm -f `docker ps -qa` ```
4. Run ```docker rmi `docker images | sed -ne '2,$p' -e 's/ */ /g' | awk '{print $1":"$2}'` ```
5. If 4 doesn't work, try ```docker rmi $(docker images | awk '/^<none>/ { print $3 }') ```

## Log files
under ```/es/logs```

## Data files
under ```/es/data```

## How to investigate query of Liferay
Enable slow query log with low threshold would be the easiest way.
1. Navigate to Sense ```http://localhost:5601/app/sense``` e.g.
2. Modify query below appropriately.

```javascript
PUT /[index_name]/_settings
{
    "index.search.slowlog.threshold.query.warn": "0s",
    "index.search.slowlog.threshold.query.info": "0s",
    "index.search.slowlog.threshold.query.debug": "0s",
    "index.search.slowlog.threshold.query.trace": "0s",
    "index.search.slowlog.threshold.fetch.warn": "0s",
    "index.search.slowlog.threshold.fetch.info": "0s",
    "index.search.slowlog.threshold.fetch.debug": "0s",
    "index.search.slowlog.threshold.fetch.trace": "0s",
    "index.indexing.slowlog.threshold.index.warn": "0s",
    "index.indexing.slowlog.threshold.index.info": "0s",
    "index.indexing.slowlog.threshold.index.debug": "0s",
    "index.indexing.slowlog.threshold.index.trace": "0s",
    "index.indexing.slowlog.level": "trace",
    "index.indexing.slowlog.source": "1000"
}
```
3. Search / index and you'll see log files under ./es/logs
you can also change ./es/config/elasticsearch.yml for above settings and run ```docker-compose up --build```

## Search from query to see how analyzer works.
1. Navigate to ```http://localhost:5601/app/sense``` and select server (http://elasticsearch:9200)
2. Paste query below
```
GET /[index_name]/_analyze
{
  "field": "title_ja_JP",
  "text":  "東京都清掃局"
}
```

## How to access elasticsearch and tools
### Elasticsearch
```http://localhost:9200```

### Kibana (Analyzing tool for Elasticsearch)
```http://localhost:5601```