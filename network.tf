resource "aws_vpc" "vpc_example"{
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet-us-east-1-1a" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.subnet_1a_cidr_block
  availability_zone = var.subnet_1a_az
  tags = {
    Name = var.subnet_1a_name
  }
}

resource "aws_subnet" "subnet-us-east-1-1b" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.subnet_1b_cidr_block
  availability_zone = var.subnet_1b_az
  tags = {
    Name = var.subnet_1b_name
  }
}

resource "aws_subnet" "subnet-public" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.subnet_public_cidr_block
  availability_zone = var.subnet_public_az
  tags = {
    Name = var.subnet_public
  }
}

resource "aws_internet_gateway" "igw-example" {
  vpc_id = aws_vpc.vpc_example.id
}

resource "aws_route_table" "route-table-public"{
  vpc_id = aws_vpc.vpc_example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-example.id
  }
  tags = {
    Name = var.route_table_public_name
  }
}

resource "aws_route_table_association" "route-table-with-vpc" {
  subnet_id         = aws_subnet.subnet-public.id
  route_table_id    = aws_route_table.route-table-public.id
}

resource "aws_eip" "elastic-ip" {
    instance = aws_instance.bastion.id
    vpc = true
}

# resource "aws_route_table" "rt-private-public" {
#     vpc_id = aws_vpc.vpc_example.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         instance_id = aws_instance.bastion.id
#     }

#     tags = {
#         Name = var.route_table_public_private_name
#     }
# }

# resource "aws_route_table_association" "rt-private1a-public" {
#     subnet_id = aws_subnet.subnet-us-east-1-1a.id
#     route_table_id = aws_route_table.rt-private-public.id
# }

# resource "aws_route_table_association" "rt-private1b-public" {
#     subnet_id = aws_subnet.subnet-us-east-1-1b.id
#     route_table_id = aws_route_table.rt-private-public.id
# }