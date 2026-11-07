resource "terraform_data" "configure_staging" {
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
    }

    command = join(" ", [
      "ansible-playbook",
      "--inventory", "ansible/inventories/staging/inventory.hcloud.yml",
      "--limit", "$STAGING_SERVER_NAME",
      "ansible/playbooks/config-staging-server.yml"
    ])
  }
}
