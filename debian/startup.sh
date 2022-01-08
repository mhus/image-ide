#!/bin/bash

if [ -z "$PASSWORD" ]; then
  PASSWORD=test
fi
su - user -c "x11vnc -storepasswd $PASSWORD /home/user/.vnc/passwd"

exec /usr/bin/supervisord -c "/etc/supervisord.conf" -n
