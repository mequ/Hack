#!/bin/bash

USER="root"
LPORT="6522"

GATEWAY="217.218.62.250"
#DOMAIN="xamin.ir"


COMMAND="ssh -fN -L $LPORT:$1:22 root@$GATEWAY"

echo "Connect to Gate way $GATEWAY"

ssh -fN -L $LPORT:$1:22 root@$GATEWAY
if [ $? -eq 0 ]; then
    echo "CONNECTION ESTABLISHED."
else
    echo "CAN NOT CONNECT TO GATEWAY"
    exit
fi

#sleep 1

SSHPID=$(ps aux| grep -F "$COMMAND" | grep -v -F 'grep'|awk '{ print $2 }')

echo  "Gate Way PID = $SSHPID"
echo "connect to server $1 ..."
ssh $USER@localhost -p $LPORT  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null 
echo "Closing gate way ..."
kill $SSHPID
