#Public Route Table - London
#Public subnets to IGW
resource "aws_route_table" "public_London" {
  vpc_id = aws_vpc.VPC_London.id

}

#Private Route Table - London
#Private subnets to NAT Gateway
resource "aws_route_table" "private_London" {
  vpc_id = aws_vpc.VPC_London.id

}

# Public route to internet gateway - London
resource "aws_route" "public_internet_London" {
  route_table_id         = aws_route_table.public_London.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_London.id

}

# Private route to NAT gateway - London
resource "aws_route" "private_nat_London" {
  route_table_id         = aws_route_table.private_London.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_London.id

}

# Route table associations for public subnets - London
resource "aws_route_table_association" "public_London" {
  count          = length(var.public_subnet_ciders)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_London.id

}

# Route table associations for private subnets - London
resource "aws_route_table_association" "private_London" {
  count          = length(var.private_subnet_ciders)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_London.id
}

#Private route to Dubai VPC peering connection 
resource "aws_route" "London_private_to_Dubai" {
  route_table_id            = aws_route_table.private_London.id
  destination_cidr_block    = "10.30.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dubai_to_london.id
}

#Public route to Dubai VPC peering connection 
resource "aws_route" "London_public_to_Dubai" {
  route_table_id            = aws_route_table.public_London.id
  destination_cidr_block    = "10.30.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dubai_to_london.id
}