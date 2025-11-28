#Public Subnets - Dubai

resource "aws_subnet" "public_subnet_Dubai" {
  count = length(var.public_subnet_ciders)

  vpc_id            = aws_vpc.VPC_Dubai.id
  cidr_block        = var.public_subnet_ciders_Dubai[count.index]
  availability_zone = data.aws_availability_zones.az_Dubai.names[count.index]

  provider = aws.Dubai

  tags = {
    Name = "Public Subnet ${count.index + 1}"
    AZ   = "data.aws_availability_zone ${count.index}"
  }
}


#Private Subnets - Dubai

resource "aws_subnet" "private_subnet_Dubai" {
  count = length(var.private_subnet_ciders)

  vpc_id            = aws_vpc.VPC_Dubai.id
  cidr_block        = var.private_subnet_ciders_Dubai[count.index]
  availability_zone = data.aws_availability_zones.az_Dubai.names[count.index]

  provider = aws.Dubai

  tags = {

    Name = "Private Subnet ${count.index + 1}"
    AZ   = "data.aws_availability_zone ${count.index}"
  }
}