FROM ubuntu:14.04

MAINTAINER Florian Bogenhard

ENV REFRESHED_AT 2015-01-30

ENV DEBIAN_FRONTEND noninteractive

RUN \
  sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list \
  && sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends git supervisor syslog-ng-core wget curl vim \
  && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV HOME /root

RUN  mkdir -p /var/log/supervisor \
  && mkdir -p /etc/supervisor/conf.d \
  && mkdir -p /etc/my_init.d/

ADD assets/supervisor.conf /etc/supervisor.conf
ADD assets/my_init.sh /usr/sbin/my_init.sh
ADD assets/00_syslog_sv.conf /etc/supervisor/conf.d/00_syslog_sv.conf
ADD assets/00_init_syslog.sh /etc/my_init.d/00_init_syslog.sh

CMD ["/usr/sbin/my_init.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
