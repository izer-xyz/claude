FROM ghcr.io/izer-xyz/oci-cli:2.26.2-amd64

USER	root

RUN	install_packages curl unzip vim-tiny jq
RUN	curl -sS https://releases.hashicorp.com/vault/1.7.3/vault_1.7.3_linux_amd64.zip -o /tmp/vault.zip \ 
	&& unzip /tmp/vault.zip  -d /usr/local/bin \
	&& rm /tmp/vault.zip

COPY	configZ /configZ/
COPY	proxZ /configZ/proxZ/	
COPY	secretZ /configZ/secretZ/
COPY	backupZ /configZ/backupZ/

ENTRYPOINT [ "/configZ/entry.sh" ]
