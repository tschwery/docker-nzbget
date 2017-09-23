FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

## Update base image and install prerequisites
RUN apk add --no-cache --virtual .fetch-deps \
        python2 py2-pip curl wget unzip

ENV NZBGETVERSION 19.1

RUN curl -SL \
    https://github.com/nzbget/nzbget/releases/download/v${NZBGETVERSION}/nzbget-${NZBGETVERSION}-bin-linux.run \
    -o /tmp/nzbget.run \
    && sh /tmp/nzbget.run --destdir /app \
    && rm /tmp/nzbget.run

ENV GROUPID 1000
ENV USERID 1000
ENV GROUPNAME nzbget
ENV USERNAME nzbget
ENV USER_HOME /home/nzbget

RUN addgroup -g ${GROUPID} -S ${USERNAME}
RUN adduser -S -G ${USERNAME} -u ${USERID} -s /bin/sh -h ${USER_HOME} ${USERNAME}

ADD start.sh /start.sh

VOLUME ["/config"]
VOLUME ["/downloads"]

USER nzbget

ENTRYPOINT ["/start.sh"]
CMD ["/app/nzbget", "-c", "/config/nzbget.conf", "-s", "-o", "outputmode=log"]
