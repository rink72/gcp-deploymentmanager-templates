output "acm_dns" {
  description = "Domain validation option"
  value       = aws_acm_certificate.kibana_cert.domain_validation_options
}
