#!/bin/bash

DATA_DIR=/opt/data
TS_DIR=/opt/teamspeak

mkdir -p $DATA_DIR/state/files
mkdir -p $DATA_DIR/logs/

# ts3server.sqlitedb
if [ ! -e $DATA_DIR/state/ts3server.sqlitedb ]; then
  touch $DATA_DIR/state/ts3server.sqlitedb
fi
if [ ! -h $TS_DIR/ts3server.sqlitedb ]; then
  ln -s $DATA_DIR/state/ts3server.sqlitedb $TS_DIR/ts3server.sqlitedb
fi

# query_ip_whitelist.txt
if [ ! -e $DATA_DIR/state/query_ip_whitelist.txt ]; then
  touch $DATA_DIR/state/query_ip_whitelist.txt
fi
if [ ! -h $TS_DIR/query_ip_whitelist.txt ]; then
  ln -s $DATA_DIR/state/query_ip_whitelist.txt $TS_DIR/query_ip_whitelist.txt
fi

# query_ip_blacklist.txt
if [ ! -e $DATA_DIR/state/query_ip_blacklist.txt ]; then
  touch $DATA_DIR/state/query_ip_blacklist.txt
fi
if [ ! -h $TS_DIR/query_ip_blacklist.txt ]; then
  ln -s $DATA_DIR/state/query_ip_blacklist.txt $TS_DIR/query_ip_blacklist.txt
fi

# /files
if [ ! -h $TS_DIR/files ]
then
  ln -s $DATA_DIR/state/files $TS_DIR/files
fi

chown -R teamspeak:teamspeak /opt/data

exit 0