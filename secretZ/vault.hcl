listener "tcp" {
	address = "0.0.0.0:8200"
	tls_disable = true
}

seal "ocikms" {
  crypto_endpoint     = "-crypto.kms.ap-sydney-1.oraclecloud.com" 
  key_id              = "ocid1.key.oc1.ap-sydney-1."
  management_endpoint = "-management.kms.ap-sydney-1.oraclecloud.com"
}

storage "oci" {
  bucket_name       = "secretz"
  ha_enabled        = "true"
  lock_bucket_name  = "secretz_lock"
  namespace_name    = ""
}

disable_clustering = true
