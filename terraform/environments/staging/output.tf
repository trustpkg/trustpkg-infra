output "server_ip" {
  description = "Public IPv4 address of the staging server"
  value       = hcloud_server.staging.ipv4_address
}