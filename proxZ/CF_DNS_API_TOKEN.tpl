{{ with printf "env/%s/proxz" (env "ROLE") | secret }}{{ .Data.data.CF_DNS_API_TOKEN }}{{ end }}
