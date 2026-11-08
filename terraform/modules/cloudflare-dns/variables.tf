variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID"
  type        = string
}

variable "cloudflare_www_record_value" {
  description = "value for the www DNS record"
  type        = string
}

variable "cloudflare_ipv4_address" {
  description = "IPv4 address for an optional A record"
  type        = string
  default     = null
}

variable "create_ipv4_record" {
  description = "Whether to create an A record"
  type        = bool
  default     = false
}

variable "record_name" {
  description = "The name for the DNS record"
  type        = string
}

variable "cloudflare_is_proxied" {
  description = "Whether the Cloudflare DNS record is proxied"
  type        = bool
  default     = false
}
