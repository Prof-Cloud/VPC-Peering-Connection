
#Public Subnets
variable "public_subnet_ciders" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.53.1.0/24", "10.53.2.0/24", "10.53.3.0/24"]
}

#Private Subnets
variable "private_subnet_ciders" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.53.11.0/24", "10.53.12.0/24", "10.53.13.0/24"]
}

#Public Subnets - Dubai
variable "public_subnet_ciders_Dubai" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
}

#Private Subnets - Dubai
variable "private_subnet_ciders_Dubai" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.30.11.0/24", "10.30.12.0/24", "10.30.13.0/24"]
}

#To ensure each pair of subnet is included per AZ (London)
data "aws_availability_zones" "az" {
  state = "available"
}

#To ensure each pair of subnet is included per AZ (Dubai)
data "aws_availability_zones" "az_Dubai" {
  state    = "available"
  provider = aws.Dubai
}

#AMI for Amazon Linux - London 
data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

#AMI for Amazon Linux - Dubai 
data "aws_ami" "dubai_ami" {
  most_recent = true
  owners      = ["amazon"]
  provider    = aws.Dubai
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}