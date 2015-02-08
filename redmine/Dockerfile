FROM datwav/ruby

MAINTAINER Florian Bogenhard
ENV REFRESHED_AT 2015-02-08
ENV REDMINE_VERSION 2.6-stable

RUN adduser redmine --home /home/redmine --shell /bin/bash --disabled-password --gecos ""
USER redmine
ENV HOME /home/redmine
RUN mkdir -p /home/redmine/web_app
WORKDIR /home/redmine/web_app

RUN git clone --branch $REDMINE_VERSION https://github.com/redmine/redmine.git . \
  && echo 'production:' >> config/database.yml \
  && echo '  adapter: "mysql2"' >> config/database.yml \
  && echo "gem 'passenger'" > Gemfile.local \
  && echo "$REDMINE_VERSION" > VERSION
USER root
RUN  bundle install --without development test doc

COPY templates/                     /home/redmine/templates
RUN chown -R redmine:redmine        /home/redmine/templates

COPY assets/01_init_redmine.sh      /etc/my_init.d/01_init_redmine.sh
COPY assets/redmine.sv.conf         /etc/supervisor/conf.d/redmine.sv.conf

