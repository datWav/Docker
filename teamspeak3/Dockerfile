FROM datwav/baseimage

MAINTAINER Florian Bogenhard

ENV REFRESHED_AT 2015-01-29
ENV TS3_VERSION 3.0.11.2

RUN apt-get update && apt-get -y upgrade

RUN adduser --home /opt/teamspeak/ --disabled-password --shell /bin/false --gecos '' teamspeak

EXPOSE 9987/udp 30033 10011
WORKDIR /opt/
RUN curl http://dl.4players.de/ts/releases/$TS3_VERSION/teamspeak3-server_linux-amd64-$TS3_VERSION.tar.gz | tar xz \
    && mv teamspeak3-server_linux-amd64/* teamspeak/ \
    && chown -R teamspeak:teamspeak teamspeak \
    && rm -r teamspeak3-server_linux-amd64

VOLUME  /opt/teamspeak/
VOLUME  /opt/data/

ADD service_teamspeak.conf /etc/supervisor/conf.d/teamspeak.conf
ADD init_teamspeak.sh /etc/my_init.d/01_teamspeak.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
