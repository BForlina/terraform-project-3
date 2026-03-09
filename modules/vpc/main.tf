resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = "two-tier-vpc"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id
}

# PUBLIC SUBNETS

resource "aws_subnet" "public1" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# PRIVATE SUBNETS

resource "aws_subnet" "private1" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private2" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "private-subnet-2"
  }
}

# ROUTE TABLE

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet" {

  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public1" {

  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2" {

  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}