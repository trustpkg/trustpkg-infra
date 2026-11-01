terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.57.0"
    }
  }
}

provider "hcloud" {
}

resource "hcloud_ssh_key" "admin" {
  name       = "admin-staging-ed25519"
  public_key = file(pathexpand("~/.ssh/admin-staging-ed25519.pub"))
}


resource "hcloud_firewall" "staging" {
  name = "staging-firewall"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = "80"
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = "443"
  }
}

resource "hcloud_server" "staging" {
  name         = "staging"
  server_type  = "cpx31"
  image        = "rocky-10"
  location     = "fsn1"
  firewall_ids = [hcloud_firewall.staging.id]
  ssh_keys     = [hcloud_ssh_key.admin.id]
  labels = {
    environment = "staging"
    managed_by  = "terraform"
  }
  user_data = templatefile("${path.module}/cloud-init.yml", {
    admin_ssh_public_key = hcloud_ssh_key.admin.public_key
  })
}
