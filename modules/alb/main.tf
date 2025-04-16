resource "aws_lb" "web_alb" {
  name = var.alb_name
  internal = false
  load_balancer_type = "application"
  security_groups = [var.security_group_id]
  subnets = var.subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "tg" {
  count = length(var.target_groups)
  name = element(var.target_groups, count.index)
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path = "/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
    matcher = "200"
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  count = length(var.target_group_attachments)
  target_group_arn = element(var.target_group_attachments, count.index).target_group_arn
  target_id = element(var.target_group_attachments, count.index).target_id
  port = 80
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid Path"
      status_code = "404"
    }
  }
}

resource "aws_lb_listener_rule" "rule" {
  count = length(var.listener_rules)
  listener_arn = aws_lb_listener.http_listener.arn
  priority = element(var.listener_rules, count.index).priority
  condition {
    path_pattern {
      values = [element(var.listener_rules, count.index).path]
    }
  }
  action {
    type = "forward"
    target_group_arn = element(var.listener_rules, count.index).target_group_arn
  }
}
