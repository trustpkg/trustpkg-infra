output "dns_record" {
  value = "${local.dns_names_components[local.dns_random_number % length(local.dns_names_components)]}-${local.dns_random_number}"
}