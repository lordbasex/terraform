# alb.tf | Load Balancer Configuration

resource "aws_security_group" "alb" {
  description = "${var.project_name}-${var.environment}-sg-terraform"
  name        = "${var.project_name}-sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      description      = ingress.value.description
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      description      = egress.value.description
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
    }
  }

  tags = {
    Name         = "${var.project_name}-${var.environment}-sg"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_security_group_rule" "nfs" {
  description              = "NFS"
  type                     = "ingress"
  from_port                = "2049"
  to_port                  = "2049"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.alb.id
}

resource "aws_alb" "application_load_balancer" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = slice(data.terraform_remote_state.vpc.outputs.public_subnets, 0, length(data.terraform_remote_state.vpc.outputs.public_subnets))
  security_groups    = [aws_security_group.alb.id]

  tags = {
    Name         = "${var.project_name}-${var.environment}-alb"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.project_name}-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name         = "${var.project_name}-target-group"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.target_group.id
  # }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate_validation.main.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.target_group.id
    type             = "forward"
  }
}