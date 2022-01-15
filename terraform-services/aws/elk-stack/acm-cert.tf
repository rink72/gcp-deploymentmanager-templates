resource "aws_acm_certificate" "kibana_cert" {
  domain_name       = "kibana.${var.r53_zonename}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Wait for cert to be validated
resource "aws_acm_certificate_validation" "kibana_cert" {
  certificate_arn         = aws_acm_certificate.kibana_cert.arn
  validation_record_fqdns = [aws_route53_record.kibana_cert_validation.fqdn]
}
