FROM %DOCKER_REGISTRY%docker-library-jre8

# Thanks to:
# Anastas Dancha <anapsix@random.io>

MAINTAINER Serge Fomin <serge.fo@gmail.com>

ENV SOLR_MIRROR http://mirrors.ocf.berkeley.edu/apache/lucene/solr
ENV SOLR_VERSION 6.0.0
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_PACKAGE $SOLR.tgz

EXPOSE 8983

RUN apk update \
  && apk add bash

ADD $SOLR_MIRROR/$SOLR_VERSION/$SOLR_PACKAGE /opt
# Keeping SOLR package locally for offline/more predictable builds
# ADD $SOLR_PACKAGE /opt

RUN gzip -dc /opt/$SOLR_PACKAGE | tar -C /opt -x \
  && ln -sf /opt/$SOLR /opt/solr \
  && rm -rf /tmp/* /opt/$SOLR_PACKAGE

WORKDIR /opt/solr
CMD bin/solr start -f
