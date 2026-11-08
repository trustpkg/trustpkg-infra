resource "terraform_data" "configure_staging" {
  depends_on = [
    module.cloudflare_api_vhost,
    module.cloudflare_app_vhost,
  ]

  triggers_replace = {
    server_id = hcloud_server.staging.id
    run_at    = timestamp()
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../.."

    environment = {
      ANSIBLE_HOST_PATTERN_MISMATCH     = "error"
      ANSIBLE_INVENTORY_UNPARSED_FAILED = "true"
      STAGING_SERVER_NAME               = hcloud_server.staging.name
      STAGING_APP_URLS = jsonencode({
        api_service_url = "${local.api_vhost_record_name}.${data.cloudflare_zone.staging.name}"
        backend_url     = "${local.api_vhost_record_name}.${data.cloudflare_zone.staging.name}"
        domain_url      = "${local.app_vhost_record_name}.${data.cloudflare_zone.staging.name}"
      })
    }

    command = join(" ", [
      "ansible-playbook",
      "--vault-password-file", "terraform/environments/staging/.vault-password",
      "--inventory", "ansible/inventories/staging/inventory.hcloud.yml",
      "--limit", "$STAGING_SERVER_NAME",
      "--extra-vars", "\"$STAGING_APP_URLS\"",
      "ansible/playbooks/config-staging-server.yml"
    ])
  }
}
