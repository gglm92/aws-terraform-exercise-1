resource "aws_efs_file_system" "efs" {
   creation_token = "efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
   tags = {
        Name = "efs-shared"
   }
}

resource "aws_security_group" "ingress-efs" {
   name = "ingress-efs-sg"
   vpc_id = aws_vpc.vpc_example.id

   ingress {
     cidr_blocks = ["12.0.0.0/16"]
     from_port = 2049
     to_port = 2049
     protocol = "tcp"
   }

   egress {
     cidr_blocks = ["12.0.0.0/16"]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
}

resource "aws_efs_mount_target" "efs-mt-subnet1" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = aws_subnet.subnet-us-east-1-1a.id
   security_groups = [aws_security_group.ingress-efs.id]
}

resource "aws_efs_mount_target" "efs-mt-subnet2" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = aws_subnet.subnet-us-east-1-1b.id
   security_groups = [aws_security_group.ingress-efs.id]
}

data "template_file" "script" {
  template = "${file("script.tpl")}"
  vars = {
    efs_id = aws_efs_file_system.efs.id
  }
}