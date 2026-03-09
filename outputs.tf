output "web_public_ips" {
  value = module.web.public_ips
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}