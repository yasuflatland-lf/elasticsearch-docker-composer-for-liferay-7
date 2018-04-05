FROM frolvlad/alpine-oraclejdk8

# ensure elasticsearch user exists
RUN addgroup -S elasticsearch && adduser -S -G elasticsearch elasticsearch

# grab su-exec for easy step-down from root
# and bash for "bin/elasticsearch" among others
RUN apk add --no-cache 'su-exec>=0.2' bash

WORKDIR /usr/share
ENV PATH /usr/share/elasticsearch/bin:$PATH

ENV ELASTICSEARCH_VERSION 6.1.3
ENV ELASTICSEARCH_TARBALL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz" \
    ELASTICSEARCH_TARBALL_SHA512="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha512"

RUN set -ex; \
    \
    apk add --no-cache --virtual .fetch-deps \
        ca-certificates \
        gnupg \
        openssl \
        tar \
    ; \
    \
    wget -O elasticsearch-$ELASTICSEARCH_VERSION.tar.gz "$ELASTICSEARCH_TARBALL"; \
    wget -O elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha512 "$ELASTICSEARCH_TARBALL_SHA512"; \
    \
    sha512sum -c elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha512; \
    \
    tar -xzvf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz; \
    rm elasticsearch-$ELASTICSEARCH_VERSION.tar.gz; \
    rm elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha512; \
    \
    mv -f elasticsearch-$ELASTICSEARCH_VERSION elasticsearch; \
    \
    apk del .fetch-deps; \
    \
    mkdir -p ./plugins; \
    for path in \
        ./elasticsearch/data \
        ./elasticsearch/logs \
        ./elasticsearch/config \
        ./elasticsearch/config/scripts \
    ; do \
        mkdir -p "$path"; \
        chown -R elasticsearch:elasticsearch "$path"; \
    done; \
    \
# we shouldn't need much RAM to test --version (default is 2gb, which gets Jenkins in trouble sometimes)
    export ES_JAVA_OPTS='-Xms32m -Xmx32m'; \
    if [ "${ELASTICSEARCH_VERSION%%.*}" -gt 1 ]; then \
        elasticsearch --version; \
    else \
# elasticsearch 1.x doesn't support --version
# but in 5.x, "-v" is verbose (and "-V" is --version)
        elasticsearch -v; \
    fi

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN elasticsearch-plugin install --batch x-pack

CMD ["elasticsearch"]

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel