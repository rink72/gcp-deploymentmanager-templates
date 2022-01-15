
resource "aws_lb" "kibana_lb" {
  name               = "samexp-${var.environment}-${var.location}-kibana"
  internal           = false
  load_balancer_type = "application"
  security_groups    = data.aws_security_group.kibana_alb_security_group.*.id
  subnets            = data.aws_subnet.kibana_alb_subnets.*.id
}

# Create target group for load balancer
resource "aws_lb_target_group" "kibana_lb_tg" {
  name     = "samexp-${var.environment}-${var.location}-kibana-tg"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id
}


# Create a port 80 -> 443 redirect listener
resource "aws_lb_listener" "kibana_lb_redirect" {
  load_balancer_arn = aws_lb.kibana_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create the SSL listener for incoming connections
resource "aws_lb_listener" "kibana_lb_listener" {
  load_balancer_arn = aws_lb.kibana_lb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = aws_acm_certificate_validation.kibana_cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana_lb_tg.id
  }
}


# Attach created EC2 instances to the load balancer
resource "aws_lb_target_group_attachment" "kibana_lb_tg_attach" {

  target_group_arn = aws_lb_target_group.kibana_lb_tg.id
  target_id        = module.elk_instance.id[0]
  port             = 5601
}
