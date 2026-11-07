variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID"
  type        = string
}

variable "cloudflare_www_record_value" {
  description = "value for the www DNS record"
  type        = string
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
