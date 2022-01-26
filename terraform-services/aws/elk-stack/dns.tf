# DNS records created for ELK stack

resource "aws_route53_record" "es_record" {
  zone_id = data.aws_route53_zone.r53zone.zone_id
  name    = "es"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.es_lb.dns_name]
}

resource "aws_route53_record" "kibana_cert_validation" {
  zone_id = data.aws_route53_zone.r53zone.zone_id
  name    = aws_acm_certificate.kibana_cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.kibana_cert.domain_validation_options[0].resource_record_type
  ttl     = "300"
  records = [aws_acm_certificate.kibana_cert.domain_validation_options[0].resource_record_value]
}

resource "aws_route53_record" "kibana_record" {
  zone_id = data.aws_route53_zone.r53zone.zone_id
  name    = "kibana"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.kibana_lb.dns_name]
}
