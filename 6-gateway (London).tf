# Internet Gateway London
resource "aws_internet_gateway" "igw_London" {
  vpc_id = aws_vpc.VPC_London.id

  tags = {
    Name = "Prof Cloud Internet Gateway"
  }
}

#Elastic IP for NAT
resource "aws_eip" "maineip_London" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw_London]

  tags = {
    Name = "Prof Cloud Elastic EIP"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "nat_London" {
  allocation_id = aws_eip.maineip_London.id

  #Use the first public subnet
  subnet_id = aws_subnet.public_subnet[0].id

  depends_on = [aws_internet_gateway.igw_London]

  tags = {
    Name = "Proj Cloud NAT Gateway"
  }
}