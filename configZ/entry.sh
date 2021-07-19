#!/usr/bin/env bash

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
( cd /configZ && tar cf - --exclude=\*.tpl *Z ) | ( cd / && tar xvf - --keep-newer-files ) 

curl -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance/id > /configZ/roleid
vault agent -config /configZ/agent.hcl

balena-idle
