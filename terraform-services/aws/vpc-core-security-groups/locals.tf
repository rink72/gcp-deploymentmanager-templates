locals {
  combined_ranges   = concat(var.ado_ranges, jsondecode(var.custom_ranges))
  mgt_sgname        = "${var.vpc_name}-ext-management-sg"
  member_sgname     = "${var.vpc_name}-member-server-sg"
  grafana_sgname    = "${var.vpc_name}-grafana-sg"
  guacamole_sgname  = "${var.vpc_name}-guacamole-sg"
  route53_sgname    = "${var.vpc_name}-route53-sg"
  kibana_alb_sgname = "${var.vpc_name}-kibana-alb-sg"
  es_sgname         = "${var.vpc_name}-elasticsearch-sg"
  kibana_sgname     = "${var.vpc_name}-kibana-sg"
}
