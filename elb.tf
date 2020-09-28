resource "aws_security_group" "sg-alb" {
  name        = "Security Group ALB"
  description = "Allow all inbound traffic"
  vpc_id     = aws_vpc.vpc_example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.subnet_1a_cidr_block]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.subnet_1b_cidr_block]
  }

  tags = {
    Name = "sg-alb"
  }

  depends_on = [
    aws_vpc.vpc_example
  ]
}

resource "aws_lb_target_group" "tg-app" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_example.id
}

resource "aws_lb_target_group_attachment" "lb-tg-web1" {
  target_group_arn = aws_lb_target_group.tg-app.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb-tg-web2" {
  target_group_arn = aws_lb_target_group.tg-app.arn
  target_id        = aws_instance.web2.id
  port             = 80
}

resource "aws_lb" "lb-example" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-web.id]
  subnets            = [
    # aws_subnet.subnet-us-east-1-1a.id,
    # aws_subnet.subnet-us-east-1-1b.id
    aws_subnet.subnet-public-nat1.id,
    aws_subnet.subnet-public-nat2.id
  ]

  tags = {
    Name = var.lb_name
  }
}

output "elb_public_ip" {
  value = aws_lb.lb-example.dns_name
}

resource "aws_alb_listener" "lb-example-listener" {  
  load_balancer_arn = aws_lb.lb-example.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = aws_lb_target_group.tg-app.arn
    type             = "forward"  
  }
}