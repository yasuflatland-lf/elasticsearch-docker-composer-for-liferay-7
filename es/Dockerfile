ARG  STACK_VERSION=$STACK_VERSION
FROM docker.elastic.co/elasticsearch/elasticsearch:$STACK_VERSION

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel