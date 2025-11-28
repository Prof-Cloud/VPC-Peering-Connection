# Internet Gateway London
resource "aws_internet_gateway" "igw_Dubai" {
  vpc_id   = aws_vpc.VPC_Dubai.id
  provider = aws.Dubai

  tags = {
    Name = "Prof Cloud Internet Gateway"
  }
}

#Elastic IP for NAT
resource "aws_eip" "maineip_Dubai" {
  domain   = "vpc"
  provider = aws.Dubai

  depends_on = [aws_internet_gateway.igw_Dubai]

  tags = {
    Name = "Prof Cloud Elastic EIP"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "nat_Dubai" {
  allocation_id = aws_eip.maineip_Dubai.id
  provider      = aws.Dubai

  #Use the first public subnet
  subnet_id = aws_subnet.public_subnet_Dubai[0].id

  depends_on = [aws_internet_gateway.igw_Dubai]

  tags = {
    Name = "Proj Cloud NAT Gateway"
  }
}