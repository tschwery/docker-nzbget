FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

## Update base image and install prerequisites
RUN apk add --no-cache --virtual .fetch-deps \
        python2 py2-pip curl wget unzip

RUN curl -SL http://nzbget.net/info/nzbget-version-linux.json \
    | grep "stable-download" \
    | cut -d '"' -f 4 \
    | xargs curl -SL -o /tmp/nzbget.run \
    && sh /tmp/nzbget.run --destdir /app \
    && rm /tmp/nzbget.run

## Used to initialize the settings
RUN pip install crudini

ENV GROUPID 1000
ENV USERID 1000
ENV GROUPNAME nzbget
ENV USERNAME nzbget
ENV USER_HOME /home/nzbget

RUN addgroup -g ${GROUPID} -S ${USERNAME}
RUN adduser -S -G ${USERNAME} -u ${USERID} -s /bin/sh -h ${USER_HOME} ${USERNAME}

ADD start.sh /start.sh

USER nzbget

ENTRYPOINT ["/start.sh"]
CMD ["/app/nzbget", "-c", "/home/nzbget/nzbget.conf", "-s", "-o", "outputmode=log"]
