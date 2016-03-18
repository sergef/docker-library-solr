FROM %DOCKER_REGISTRY%docker-library-jre8

# Thanks to:
# Anastas Dancha <anapsix@random.io>

MAINTAINER Serge Fomin <serge.fo@gmail.com>

ENV SOLR_MIRROR http://mirrors.ocf.berkeley.edu/apache/lucene/solr
ENV SOLR_VERSION 5.5.0
ENV SOLR_PACKAGE solr-$SOLR_VERSION.tgz

EXPOSE 8983

ADD $SOLR_MIRROR/$SOLR_VERSION/$SOLR_PACKAGE /opt
# Keeping SOLR package locally for offline/more predictable builds
# ADD $SOLR_PACKAGE /opt

RUN ln -sf /opt/$SOLR /opt/solr \
  && rm -rf /tmp/*

WORKDIR /opt/solr

CMD bin/solr start -f
