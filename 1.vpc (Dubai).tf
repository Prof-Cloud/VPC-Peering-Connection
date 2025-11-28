#VPC in Dubai region
resource "aws_vpc" "VPC_Dubai" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  provider = aws.Dubai

  tags = {
    Name = "Prof Cloud VPC Dubai"

  }
}