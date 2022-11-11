# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.subnet_vpc
  tags = {
    "app_tag" = "aws-infra"
  }
}

# subnet dmz
resource "aws_subnet" "subnet_dmz" {
  cidr_block              = var.subnet_dmz
  map_public_ip_on_launch = var.auto_assign_ip
  vpc_id                  = aws_vpc.main_vpc.id
  tags = {
    "tier" = "frontend"
  }
}

resource "aws_route_table_association" "dmz_table" {
  route_table_id = aws_vpc.main_vpc.default_route_table_id
  subnet_id      = aws_subnet.subnet_dmz.id
}

resource "aws_route" "internet_dmz_route" {
  route_table_id         = aws_vpc.main_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# subnet internal
resource "aws_subnet" "subnet_internal" {
  cidr_block              = var.subnet_internal
  vpc_id                  = aws_vpc.main_vpc.id
  map_public_ip_on_launch = var.auto_assign_ip
}

# internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
}

#resource "aws_nat_gateway" "aws_nat_gateway" {
#  allocation_id = aws_eip.nat_eip.id
#  subnet_id     = aws_subnet.subnet_dmz.id
#  depends_on    = [aws_internet_gateway.internet_gateway]
#}

# EIP
resource "aws_eip" "nat_eip" {
  vpc = true
}
