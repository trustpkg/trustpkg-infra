locals {
  app_vhost_record_name = module.record_name_generator.dns_record
  api_vhost_record_name = "${module.record_name_generator.dns_record}-api"
}