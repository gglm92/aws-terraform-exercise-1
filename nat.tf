resource "aws_subnet" "subnet-public-nat1" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.subnet_public_cidr_block_nat1
  availability_zone = var.subnet_public_az_nat1
  tags = {
    Name = "Subnet - public NAT"
  }
}

resource "aws_route_table" "rt-public-nat"{
  vpc_id = aws_vpc.vpc_example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-example.id
  }
  tags = {
    Name = "Route Table public NAT"
  }
}

resource "aws_route_table_association" "route-table-public-nat1" {
  subnet_id         = aws_subnet.subnet-public-nat1.id
  route_table_id    = aws_route_table.rt-public-nat.id
}

resource "aws_eip" "elastic-ip-nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.elastic-ip-nat.id
    subnet_id = aws_subnet.subnet-public-nat1.id
    depends_on = [aws_internet_gateway.igw-example]
}

resource "aws_route_table" "rt-private-nat"{
  vpc_id = aws_vpc.vpc_example.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "terraformtraining-private-1"
  }
}

resource "aws_route_table_association" "rta-private-1a" {
    subnet_id = aws_subnet.subnet-us-east-1-1a.id
    route_table_id = aws_route_table.rt-private-nat.id
}

resource "aws_route_table_association" "rta-private-1b" {
    subnet_id = aws_subnet.subnet-us-east-1-1b.id
    route_table_id = aws_route_table.rt-private-nat.id
}