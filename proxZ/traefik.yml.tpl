api:
  dashboard: true

serversTransport:
  insecureSkipVerify: true

entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"
    http:
      tls:
        certresolver: cloudflare
        domains:
          - main:   "{{ with printf "env/%s/proxz" (env "ROLE") | secret }}{{ .Data.data.DOMAIN }}{{ end }}"
            sans: "*.{{ with printf "env/%s/proxz" (env "ROLE") | secret }}{{ .Data.data.DOMAIN }}{{ end }}"

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    watch: true
    defaultRule: "Host(`{{ `{{ index .Labels \"com.docker.compose.service\" }}` }}.{{ with printf "env/%s/proxz" (env "ROLE") | secret }}{{ .Data.data.DOMAIN }}{{ end }}`)"

certificatesResolvers:
  cloudflare:
    acme:
      email: {{ with printf "env/%s/proxz" (env "ROLE") | secret }}{{ .Data.data.DOMAIN_EMAIL }}{{ end }}
      storage: /etc/certz/acme.json
      dnsChallenge:
        provider: cloudflare
        resolvers:
          - "1.1.1.1:53"
          - "1.0.0.1:53"

