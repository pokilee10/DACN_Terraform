# Create Target Group for Service 1
resource "aws_lb_target_group" "service_1_tg" {
  name        = "service-1-tg"
  port        = 3000
  protocol    = "TCP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "ip"

  health_check {
    protocol = "TCP"
  }

  tags = {
    Name = "Service 1 Target Group"
  }
}

# Create Target Group for Service 2
resource "aws_lb_target_group" "service_2_tg" {
  name        = "service-2-tg"
  port        = 4000
  protocol    = "TCP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "ip"

  health_check {
    protocol = "TCP"
  }

  tags = {
    Name = "Service 2 Target Group"
  }
}

# Create Target Group for Service 3
resource "aws_lb_target_group" "service_3_tg" {
  name        = "service-3-tg"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "ip"

  health_check {
    protocol = "TCP"
  }

  tags = {
    Name = "Service 3 Target Group"
  }
}
# Create Listener for Service 1 NLB
resource "aws_lb_listener" "service_1_listener" {
  load_balancer_arn = aws_lb.service_1_nlb.arn
  port              = 3000
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_1_tg.arn
  }

  tags = {
    Name = "Service 1 Listener"
  }
}

# Create Listener for Service 2 NLB
resource "aws_lb_listener" "service_2_listener" {
  load_balancer_arn = aws_lb.service_2_nlb.arn
  port              = 4000
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_2_tg.arn
  }

  tags = {
    Name = "Service 2 Listener"
  }
}

# Create Listener for Service 3 NLB
resource "aws_lb_listener" "service_3_listener" {
  load_balancer_arn = aws_lb.service_3_nlb.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_3_tg.arn
  }

  tags = {
    Name = "Service 3 Listener"
  }
}