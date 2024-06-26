resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name  = join("-", [var.base_name, "VPC"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name  = join("-", [var.base_name, "private-subnet-a"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1b"
  tags = {
    Name  = join("-", [var.base_name, "private-subnet-b"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.128.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name  = join("-", [var.base_name, "public-subnet-a"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.144.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name  = join("-", [var.base_name, "public-subnet-b"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = join("-", [var.base_name, "internet-gateway"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name  = join("-", [var.base_name, "public-route-table"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_route_table_association" "public_route_table_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name  = join("-", [var.base_name, "private-route-table-a"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_route_table_association" "private_route_table_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
  tags = {
    Name  = join("-", [var.base_name, "private-route-table-b"])
    Notes = var.generic_tag_notes
  }
}
resource "aws_route_table_association" "private_route_table_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_b.id
}

resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  tags = {
    Name  = join("-", [var.base_name, "private-nat_gateway_eip"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags = {
    Name  = join("-", [var.base_name, "nat-gatway"])
    Notes = var.generic_tag_notes
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_vpc_endpoint" "s3_private_endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    Name  = join("-", [var.base_name, "s3-private-endpoint"])
    Notes = var.generic_tag_notes
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_endpoint_vpc_association_a" {
  route_table_id  = aws_route_table.private_route_table_a.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_private_endpoint.id
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_endpoint_vpc_association_b" {
  route_table_id  = aws_route_table.private_route_table_b.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_private_endpoint.id
}
