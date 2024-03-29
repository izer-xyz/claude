exit_after_auth = true

auto_auth {
	method "approle" {
		config = {
			role_id_file_path = "/configZ/roleid"
		}
	}
}

template {
	source		= "/configZ/proxZ/traefik.yml.tpl"
	destination	= "/proxZ/traefik.yml"
}

template {
	source		= "/configZ/proxZ/CF_DNS_API_TOKEN.tpl"
	destination	= "/proxZ/CF_DNS_API_TOKEN"
}

template {
        source          = "/configZ/backupZ/preferences.tpl"
        destination     = "/backupZ/preferences"                                                                
}
