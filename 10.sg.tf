#Securitty Group For Linux Server - London
resource "aws_security_group" "Linux_Server_London" {
  name        = "Linux_Server"
  description = "Allow HTTP, SSH, ICMP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.VPC_London.id

  tags = {
    Name = "Linux Server SG"
  }
}

#Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_London_ipv4" {
  security_group_id = aws_security_group.Linux_Server_London.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "Linux_Server_London_ssh" {
  security_group_id = aws_security_group.Linux_Server_London.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

#Ping
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_London_icmp_from_Dubai" {
  security_group_id = aws_security_group.Linux_Server_London.id
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_ipv4         = "10.30.0.0/16"  # Dubai VPC CIDR
}

# Allow HTTP from Dubai VPC
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_London_http_from_Dubai" {
  security_group_id = aws_security_group.Linux_Server_London.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4        = "10.30.0.0/16"   # Dubai VPC CIDR
}


#Outbound Rules
resource "aws_vpc_security_group_egress_rule" "Linux_Server_London_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Linux_Server_London.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#Securitty Group For Linux Server - Dubai
resource "aws_security_group" "Linux_Server_Dubai" {
  name        = "Linux_Server"
  description = "Allow HTTP, SSH, ICMP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.VPC_Dubai.id
  provider    = aws.Dubai

  tags = {
    Name = "Linux Server SG"
  }
}

#Inbound Rules 
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_Dubai_ipv4" {
  security_group_id = aws_security_group.Linux_Server_Dubai.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  provider          = aws.Dubai
}

resource "aws_vpc_security_group_ingress_rule" "Linux_Server_Dubai_ssh" {
  security_group_id = aws_security_group.Linux_Server_Dubai.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  provider          = aws.Dubai
}

#ping
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_Dubai_icmp_from_London" {
  security_group_id = aws_security_group.Linux_Server_Dubai.id
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_ipv4         = "10.53.0.0/16"  # London VPC CIDR
  provider          = aws.Dubai
}
# Allow HTTP from London VPC
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_Dubai_http_from_London" {
  security_group_id = aws_security_group.Linux_Server_Dubai.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4        = "10.53.0.0/16"   # London VPC CIDR
  provider          = aws.Dubai
}

#Outbound Rules
resource "aws_vpc_security_group_egress_rule" "Linux_ServerDubai_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Linux_Server_Dubai.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  provider          = aws.Dubai
}
