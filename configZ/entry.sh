#!/usr/bin/env bash

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
( cd /configZ && tar cf - --exclude=\*.tpl *Z ) | ( cd / && tar xvf - --keep-newer-files ) 

echo $BALENA_DEVICE_UUID > /configZ/roleid
vault agent -config /configZ/agent.hcl

balena-idle
