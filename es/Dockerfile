FROM docker.elastic.co/elasticsearch/elasticsearch:7.11.1

COPY ./elasticsearch-analysis-kuromoji-ipadic-neologd-7.11.1-SNAPSHOT.zip ./

RUN elasticsearch-plugin install file:./elasticsearch-analysis-kuromoji-ipadic-neologd-7.11.1-SNAPSHOT.zip
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel