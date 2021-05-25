FROM docker.elastic.co/elasticsearch/elasticsearch:7.9.3

COPY ./elasticsearch-analysis-kuromoji-ipadic-neologd-7.9.3-SNAPSHOT.zip ./

RUN elasticsearch-plugin install file:./elasticsearch-analysis-kuromoji-ipadic-neologd-7.9.3-SNAPSHOT.zip
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel