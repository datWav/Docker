#!/bin/bash

INSTALL_DIR=/home/redmine/web_app
CONFIG_DIR=$INSTALL_DIR/config
TEMPLATE_DIR=/home/redmine/templates
DATA_DIR=/data/redmine
mkdir -p $DATA_DIR

# save uploaded files
if [ ! -h "$INSTALL_DIR/files" ]; then
  rm -rf $INSTALL_DIR/files
  mkdir -p $DATA_DIR/files
  ln -s $DATA_DIR/files $INSTALL_DIR/files
  chmod -R 755 $INSTALL_DIR/files
fi

# user defined configuration file
if [ ! -h "$INSTALL_DIR/config/configuration.yml" ]; then
  if [ ! -e "$DATA_DIR/configuration.yml" ]; then
    cp $INSTALL_DIR/config/configuration.yml.example $DATA_DIR/configuration.yml
  fi
  ln -s $DATA_DIR/configuration.yml $INSTALL_DIR/config/configuration.yml
fi

# setup database connection
cp -f $TEMPLATE_DIR/database.yml $CONFIG_DIR/database.yml

sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i $CONFIG_DIR/database.yml
sed 's/{{DB_HOST}}/'"${DB_PORT_3306_TCP_ADDR}"'/' -i $CONFIG_DIR/database.yml
sed 's/{{DB_PORT}}/'"${DB_PORT_3306_TCP_PORT}"'/' -i $CONFIG_DIR/database.yml
sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i $CONFIG_DIR/database.yml
sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i $CONFIG_DIR/database.yml

# do database migration and creation if needed
INSTALLED_VERSION=

if [ -f "$DATA_DIR/REDMINE_VERSION" ]; then
  INSTALLED_VERSION=$(cat $DATA_DIR/REDMINE_VERSION)

  if [ "$REDMINE_VERSION" != "$INSTALLED_VERSION" ]; then
    sudo -u redmine RAILS_ENV=production bundle exec rake db:migrate

    echo "$REDMINE_VERSION" > $DATA_DIR/REDMINE_VERSION
  fi
else
  sudo -u redmine RAILS_ENV=production bundle exec rake db:create
  sudo -u redmine RAILS_ENV=production bundle exec rake db:migrate
  sudo -u redmine -H REDMINE_LANG=en RAILS_ENV=production bundle exec rake redmine:load_default_data

  echo "$REDMINE_VERSION" > $DATA_DIR/REDMINE_VERSION
fi

# themes
if [ ! -h "$INSTALL_DIR/public/themes" ]; then
  if [ ! -e "$DATA_DIR/themes" ]; then
    cp $INSTALL_DIR/public/themes $DATA_DIR/themes
  else
    rm -rf $INSTALL_DIR/public/themes
  fi
  ln -s $DATA_DIR/themes $INSTALL_DIR/public/themes
fi

# secret
if [ ! -e "$INSTALL_DIR/config/initializers/secret.rb" ]; then
  sudo -u redmine -H RAILS_ENV=production bundle exec rake generate_secret_token
fi

chown -R redmine:redmine $INSTALL_DIR/files $DATA_DIR/files $DATA_DIR/configuration.yml $INSTALL_DIR/public/themes
