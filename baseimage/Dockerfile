FROM ubuntu:14.04

MAINTAINER Florian Bogenhard

ENV REFRESHED_AT 2015-01-29

ENV DEBIAN_FRONTEND noninteractive

RUN \
  sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list \
  && sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y git supervisor wget curl vim \
  && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV HOME /root

RUN  mkdir -p /var/log/supervisor \
  && mkdir -p /etc/supervisor/conf.d \
  && mkdir -p /etc/my_init.d/

ADD supervisor.conf /etc/supervisor.conf
ADD my_init.sh /usr/bin/my_init.sh

CMD ["/usr/bin/my_init.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
