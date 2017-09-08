FROM sergef/docker-library-alpine:edge

ENV SOLR_MIRROR http://mirrors.ocf.berkeley.edu/apache/lucene/solr
ENV SOLR_VERSION 6.6.1
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_PACKAGE $SOLR.tgz

EXPOSE 8983

ADD $SOLR_MIRROR/$SOLR_VERSION/$SOLR_PACKAGE /opt/

RUN apk add --no-cache \
    bash \
    openjdk8-jre@community \
  && gzip -dc /opt/$SOLR_PACKAGE | tar -C /opt -x \
  && addgroup -S solr \
  && adduser -G solr -s /sbin/nologin -H -D solr \
  && chown -R solr:solr /opt/$SOLR \
  && ln -sf /opt/$SOLR /opt/solr \
  && rm -rf \
    /tmp/* \
    /opt/$SOLR_PACKAGE

USER solr
WORKDIR /opt/solr

ENTRYPOINT ["/opt/solr/bin/solr", "start", "-f"]
