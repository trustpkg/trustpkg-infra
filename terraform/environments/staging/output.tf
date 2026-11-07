output "server_ipv6" {
  description = "Public IPv6 address of the staging server"
  value       = hcloud_server.staging.ipv6_address
}

output "server_ipv4" {
  description = "Public IPv4 address of the staging server"
  value       = hcloud_server.staging.ipv4_address
}

output "dns_record_base" {
  description = "Base name for the DNS record"
  value       = local.app_vhost_record_name
}

output "app_dns_record" {
  description = "Base name for the app DNS record"
  value       = local.app_vhost_record_name
}

output "api_dns_record" {
  description = "Base name for the API DNS record"
  value       = local.api_vhost_record_name
}

output "domain" {
  description = "Cloudflare zone domain name"
  value       = data.cloudflare_zone.staging.name
}
