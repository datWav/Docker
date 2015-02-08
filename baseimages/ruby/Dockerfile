FROM datwav/baseimage

MAINTAINER Florian Bogenhard

ENV REFRESHED_AT 2015-02-05

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C3173AA6 \
 && echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get -y install \
  build-essential ca-certificates g++ git-core libgraphviz-dev libgvc6 libmagickcore-dev libmagickcore5-extra \
  libmagickwand-dev libmysqlclient-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libxslt-dev \
  libxslt1-dev libyaml-0-2 libyaml-dev make mysql-client patch ruby2.1 ruby2.1-dev zlib1g-dev imagemagick

# FIX for new SSL Cert from rubygems for broken ruby version
ADD https://github.com/rubygems/rubygems/releases/download/v2.2.3/rubygems-update-2.2.3.gem /tmp/rubygems-update-2.2.3.gem
RUN gem install --local /tmp/rubygems-update-2.2.3.gem \
  && update_rubygems --no-ri --no-rdoc \
  && gem install bundle

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
