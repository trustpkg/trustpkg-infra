terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = var.record_name
  content = var.cloudflare_www_record_value
  proxied = var.cloudflare_is_proxied
  type    = "AAAA"
  ttl     = 1
}

resource "cloudflare_dns_record" "ipv4" {
  count   = var.create_ipv4_record ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = var.record_name
  content = var.cloudflare_ipv4_address
  proxied = var.cloudflare_is_proxied
  type    = "A"
  ttl     = 1

  lifecycle {
    precondition {
      condition     = var.cloudflare_ipv4_address != null && try(trimspace(var.cloudflare_ipv4_address) != "", false)
      error_message = "An IPv4 address is required when create_ipv4_record is enabled."
    }
  }
}
