resource "shoreline_notebook" "apache_server_info_disclosure_incident" {
  name       = "apache_server_info_disclosure_incident"
  data       = file("${path.module}/data/apache_server_info_disclosure_incident.json")
  depends_on = [shoreline_action.invoke_apache_config_check,shoreline_action.invoke_update_apache,shoreline_action.invoke_httpd_config_backup_and_disable_signatures]
}

resource "shoreline_file" "apache_config_check" {
  name             = "apache_config_check"
  input_file       = "${path.module}/data/apache_config_check.sh"
  md5              = filemd5("${path.module}/data/apache_config_check.sh")
  description      = "Misconfiguration of Apache server settings that allowed unauthorized access to sensitive server information."
  destination_path = "/agent/scripts/apache_config_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "update_apache" {
  name             = "update_apache"
  input_file       = "${path.module}/data/update_apache.sh"
  md5              = filemd5("${path.module}/data/update_apache.sh")
  description      = "Update the Apache server software to the latest version to address known vulnerabilities."
  destination_path = "/agent/scripts/update_apache.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "httpd_config_backup_and_disable_signatures" {
  name             = "httpd_config_backup_and_disable_signatures"
  input_file       = "${path.module}/data/httpd_config_backup_and_disable_signatures.sh"
  md5              = filemd5("${path.module}/data/httpd_config_backup_and_disable_signatures.sh")
  description      = "Disable server info disclosure by modifying the Apache configuration file (httpd.conf) to remove the "ServerSignature" and "ServerTokens" directives."
  destination_path = "/agent/scripts/httpd_config_backup_and_disable_signatures.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_config_check" {
  name        = "invoke_apache_config_check"
  description = "Misconfiguration of Apache server settings that allowed unauthorized access to sensitive server information."
  command     = "`chmod +x /agent/scripts/apache_config_check.sh && /agent/scripts/apache_config_check.sh`"
  params      = []
  file_deps   = ["apache_config_check"]
  enabled     = true
  depends_on  = [shoreline_file.apache_config_check]
}

resource "shoreline_action" "invoke_update_apache" {
  name        = "invoke_update_apache"
  description = "Update the Apache server software to the latest version to address known vulnerabilities."
  command     = "`chmod +x /agent/scripts/update_apache.sh && /agent/scripts/update_apache.sh`"
  params      = []
  file_deps   = ["update_apache"]
  enabled     = true
  depends_on  = [shoreline_file.update_apache]
}

resource "shoreline_action" "invoke_httpd_config_backup_and_disable_signatures" {
  name        = "invoke_httpd_config_backup_and_disable_signatures"
  description = "Disable server info disclosure by modifying the Apache configuration file (httpd.conf) to remove the "ServerSignature" and "ServerTokens" directives."
  command     = "`chmod +x /agent/scripts/httpd_config_backup_and_disable_signatures.sh && /agent/scripts/httpd_config_backup_and_disable_signatures.sh`"
  params      = []
  file_deps   = ["httpd_config_backup_and_disable_signatures"]
  enabled     = true
  depends_on  = [shoreline_file.httpd_config_backup_and_disable_signatures]
}

