#!/bin/bash

INIT_SCRIPT=/etc/my_init.d/

for FILE in `ls $INIT_SCRIPT | sort -V` ; do
  SCRIPT=$INIT_SCRIPT$FILE
  if [ -f $SCRIPT -a -x $SCRIPT ] ; then
    echo "Execute script: $FILE"
    $SCRIPT
  fi
done

trap 'kill -SIGHUP $PID' SIGHUP
trap 'kill -SIGINT $PID' SIGINT
trap 'kill -SIGQUIT $PID' SIGQUIT
trap 'kill -SIGKILL $PID' SIGKILL
trap 'kill -SIGTERM $PID' SIGTERM

supervisord -c /etc/supervisor.conf &
# FROM: http://veithen.github.io/2014/11/16/sigterm-propagation.html
PID=$!
wait $PID
trap - SIGHUP SIGINT SIGQUIT SIGKILL SIGTERM
wait $PID
EXIT_STATUS=$?
