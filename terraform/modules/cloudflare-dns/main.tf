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
