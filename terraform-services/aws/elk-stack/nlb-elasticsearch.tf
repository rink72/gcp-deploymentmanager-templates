
# Create NLB for elasticsearch servers
# This will balance load between all elasticsearch servers
resource "aws_lb" "es_lb" {
  name               = "samexp-${var.environment}-${var.location}-es"
  internal           = true
  load_balancer_type = "network"
  subnets            = data.aws_subnet.lb_subnets.*.id

  tags = {
    Owner       = var.owner,
    Environment = var.environment
  }
}

# Create target group for load balancer
# We use IP target type so that instances can talk to themselves through the LB
# https://aws.amazon.com/premiumsupport/knowledge-center/target-connection-fails-load-balancer/
resource "aws_lb_target_group" "es_lb_tg" {
  name        = "samexp-${var.environment}-${var.location}-es-tg"
  port        = 9200
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"
}

# Create the SSL listener for incoming connections
resource "aws_lb_listener" "es_lb_listener" {
  load_balancer_arn = aws_lb.es_lb.id
  port              = "9200"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es_lb_tg.id
  }
}


# Attach created EC2 instances to the load balancer
resource "aws_lb_target_group_attachment" "es_lb_tg_attach" {

  target_group_arn = aws_lb_target_group.es_lb_tg.id
  target_id        = module.elk_instance.private_ip[0]
  port             = 9200
}
