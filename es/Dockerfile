FROM elasticsearch:2.4-alpine

RUN bin/plugin install analysis-kuromoji
RUN bin/plugin install analysis-icu
RUN bin/plugin install analysis-smartcn
RUN bin/plugin install analysis-stempel
RUN bin/plugin install royrusso/elasticsearch-HQ/v2.0.3