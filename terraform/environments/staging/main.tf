terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.57.0"
    }
  }
}

provider "hcloud" {
}

data "cloudflare_zone" "staging" {
  zone_id = var.cloudflare_zone_id
}

resource "hcloud_ssh_key" "admin" {
  name       = "admin-staging-ed25519"
  public_key = file(pathexpand("~/.ssh/admin-staging-ed25519.pub"))
}

module "record_name_generator" {
  source = "../../modules/generate-random-name"
}

module "cloudflare_api_vhost" {
  source                      = "../../modules/cloudflare-dns"
  record_name                 = local.api_vhost_record_name
  cloudflare_is_proxied       = false
  cloudflare_zone_id          = var.cloudflare_zone_id
  cloudflare_www_record_value = hcloud_server.staging.ipv6_address
}

module "cloudflare_app_vhost" {
  source                      = "../../modules/cloudflare-dns"
  record_name                 = local.app_vhost_record_name
  cloudflare_is_proxied       = false
  cloudflare_zone_id          = var.cloudflare_zone_id
  cloudflare_www_record_value = hcloud_server.staging.ipv6_address
}

resource "hcloud_firewall" "staging" {
  name = "staging-firewall"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_server" "staging" {
  name         = "staging"
  server_type  = "cx23"
  image        = "rocky-10"
  location     = "hel1"
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
