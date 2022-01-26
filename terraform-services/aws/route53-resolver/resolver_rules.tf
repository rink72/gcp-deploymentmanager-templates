# These are the resolver rules. They are dynamically defined by the array of domains passed in to the deployment.
# Each domain passed in will be sent to our internal DNS for resolution. This rule resource will create a rule for each domain
# and then add each of the internal DNS IP addresses as possible places to resolve queries
resource "aws_route53_resolver_rule" "resolver_rules" {
  for_each = toset(var.internal_domain_list)

  name                 = "${replace(each.value, ".", "_")}-forwarding"
  domain_name          = each.value
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.private_vpc_outbound_resolver.id

  dynamic "target_ip" {
    for_each = var.internal_dns_servers

    content {
      ip = target_ip.value
    }
  }

  tags = local.tags
}

# This resource assigns the rules created above to the required VPCs
resource "aws_route53_resolver_rule_association" "private_vpc_resolver_rule_association" {
  for_each = toset(var.internal_domain_list)

  resolver_rule_id = aws_route53_resolver_rule.resolver_rules[each.value].id
  vpc_id           = data.aws_vpc.private_vpc.id
}
