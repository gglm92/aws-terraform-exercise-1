resource "aws_security_group" "sg-bastion" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.vpc_example.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_instance" "bastion" {
  ami                         = var.instance_ami_bastion
  instance_type               = var.instance_type_bation
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.subnet-public.id
  vpc_security_group_ids      = [aws_security_group.sg-bastion.id]
  key_name                    = var.instance_key_name
  tags = {
    type = var.instance_tag_type
  }

  provisioner "file" {
    source      = var.private_key_path
    destination = "/home/ec2-user/.ssh/${var.private_key_file}"
  }
  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
  }

  user_data = <<EOF
		          #! /bin/bash
              echo "IdentityFile ~/.ssh/${var.private_key_file}" > /home/ec2-user/.ssh/config
		          chmod 400 /home/ec2-user/.ssh/config
		          chown ec2-user:ec2-user /home/ec2-user/.ssh/config
              sleep 60
		          chmod 400 /home/ec2-user/.ssh/${var.private_key_file}
              EOF
}

resource "aws_security_group" "sg-web" {
    name = var.security_group_web_name
    description = var.security_group_web_description

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    vpc_id = aws_vpc.vpc_example.id

    tags = {
        Name = var.security_group_web_name
    }
}

resource "aws_instance" "web1" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet-us-east-1-1a.id
  vpc_security_group_ids      = [aws_security_group.sg-web.id]
  key_name                    = var.instance_key_name
  user_data                   = data.template_file.script.rendered
  tags = {
    type = var.instance_tag_type
  }
}

resource "aws_instance" "web2" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet-us-east-1-1b.id
  vpc_security_group_ids      = [aws_security_group.sg-web.id]
  key_name                    = var.instance_key_name
  user_data                   = data.template_file.script.rendered
  tags = {
    type = var.instance_tag_type
  }
}

