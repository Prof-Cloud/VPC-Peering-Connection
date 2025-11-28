#Public Route Table - Dubai
#Public subnets to IGW
resource "aws_route_table" "public_Dubai" {
  vpc_id   = aws_vpc.VPC_Dubai.id
  provider = aws.Dubai
}

#Private Route Table - Dubai
#Private subnets to NAT Gateway
resource "aws_route_table" "private_Dubai" {
  vpc_id   = aws_vpc.VPC_Dubai.id
  provider = aws.Dubai
}

# Public route to internet gateway - Dubai
resource "aws_route" "public_internet_Dubai" {
  route_table_id         = aws_route_table.public_Dubai.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_Dubai.id
  provider               = aws.Dubai
}

# Private route to NAT gateway - Dubai
resource "aws_route" "private_nat_Dubai" {
  route_table_id         = aws_route_table.private_Dubai.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_Dubai.id
  provider               = aws.Dubai
}

# Route table associations for public subnets - Dubai
resource "aws_route_table_association" "public_Dubai" {
  count          = length(var.public_subnet_ciders_Dubai)
  subnet_id      = aws_subnet.public_subnet_Dubai[count.index].id
  route_table_id = aws_route_table.public_Dubai.id
  provider       = aws.Dubai
}

# Route table associations for private subnets - Dubai
resource "aws_route_table_association" "private_Dubai" {
  count          = length(var.private_subnet_ciders_Dubai)
  subnet_id      = aws_subnet.private_subnet_Dubai[count.index].id
  route_table_id = aws_route_table.private_Dubai.id
  provider       = aws.Dubai
}

#Private route to London VPC peering connection 
resource "aws_route" "Dubai_private_to_London" {
  route_table_id            = aws_route_table.private_Dubai.id
  destination_cidr_block    = "10.53.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dubai_to_london.id
  provider                  = aws.Dubai
}

#Public route to London VPC peering connection
resource "aws_route" "Dubai_public_to_London" {
  route_table_id            = aws_route_table.public_Dubai.id
  destination_cidr_block    = "10.53.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dubai_to_london.id
  provider                  = aws.Dubai
}
