# elasticsearch-docker-composer-for-liferay-7

This is for setting up docker-composer to test Elasticsearch and Kuromoji against Liferay 7.3 GA1 / DXP 7.3 SP1 (Elasticsearch 7.9.3).

## Required environment

- Docker 3.3.3 >=
- Java8 or Java11

## How to set up

1. Clone this repository
1. Change the file permission of `/es/docker-entrypoint.sh` to executable.
1. Go back to the root folder and run `docker-compose up --build` or just `docker-compose up`
1. Start Liferay 7.3
1. Login as an administrator and navigate to Control Panel -> Configuration -> System Setting -> Search -> Elasticsearch 7
1. Check `Production Mode Enabled` true.
1. Open `index-settings.json` and paste it into `Additional Index Configurations` Text field.
1. Open `liferay-type-mappings.json` and paste it into `Override Type Mappings` Text field.
1. Click save and restart Liferay server
1. Loging as an administrator, navigate to Control Panel -> Configuration -> Server Configuration and run reindex.

## Modify user dictionary

1. Open /es/config/userdict_ja.txt
2. Modify contents according to the [user guide](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji-tokenizer.html)

## Initialize set up after change configurations

1. Stop services with `docker-compose stop`
2. Delete folders under `/es/data`
3. Run `` docker rm -f `docker ps -qa`  ``
4. Run `` docker rmi `docker images | sed -ne '2,$p' -e 's/ */ /g' | awk '{print $1":"$2}'`  ``
5. If 4 doesn't work, try `docker rmi $(docker images | awk '/^<none>/ { print $3 }') `

## Log files

under `/es/logs`

## Data files

under `/es/data`

## How to investigate query of Liferay

Enable slow query log with low threshold would be the easiest way.

1. Navigate to Sense `http://localhost:5601/app/dev_tools#/console` e.g.
1. Find index names at `http://localhost:5601/app/management/data/index_management/indices`.
1. Modify query below appropriately.

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
   you can also change ./es/config/elasticsearch.yml for above settings and run `docker-compose up --build`

## Search from query to see how analyzer works.

1. Navigate to `http://localhost:5601/app/dev_tools#/console`
1. Paste query below

```
GET /[index_name]/_analyze
{
  "field": "title_ja_JP",
  "text":  "東京都清掃局"
}
```

## How to access elasticsearch and tools

### Elasticsearch

`http://localhost:9200`

### Kibana (Analyzing tool for Elasticsearch)

`http://localhost:5601`
