#!/usr/bin/env bash

cd /configZ

export VAULT_FORMAT=json

ROLEID=$BALENA_DEVICE_UUID
ROLE=$BALENA_APP_NAME

echo create role: $ROLE
vault policy write $ROLE - <<EOF
path "env/data/$ROLE/*" {
  capabilities = ["read"]
}
EOF

CIDR=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
vault write auth/approle/role/$ROLE bound_cidr_list=$CIDR bind_secret_id=false policies=$ROLE
vault write auth/approle/role/$ROLE/role-id role_id=$ROLEID

echo find and create secrets

vault kv put env/$ROLE/logz \
	ELASTIC_HOST="$ELASTIC_HOST" \
	ELASTIC_INDEX="$ELASTIC_INDEX"

vault kv put env/$ROLE/proxz \
	DOMAIN="$DOMAIN" \
	DOMAIN_EMAIL="$DOMAIN_EMAIL" \
	CF_DNS_API_TOKEN="$CF_DNS_API_TOKEN"

echo Init done time to reboot...
# reboot
