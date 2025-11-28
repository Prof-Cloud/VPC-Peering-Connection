#Dubai initiates the request
resource "aws_vpc_peering_connection" "dubai_to_london" {
  vpc_id      = aws_vpc.VPC_Dubai.id
  peer_vpc_id = aws_vpc.VPC_London.id
  peer_region = "eu-west-2"
  auto_accept = false #AWS does not allow automatic acceptance of cross-region VPC peering requests.
  provider    = aws.Dubai

  tags = {
    Name = "Dubai-to-London"
  }
}

#London accepts the peering
resource "aws_vpc_peering_connection_accepter" "london_accepts" {
  vpc_peering_connection_id = aws_vpc_peering_connection.dubai_to_london.id
  auto_accept               = true #London accept automatic
  # provider                  = aws.London  # Your London provider alias

  tags = {
    Name = "London-Accepts-Dubai"
  }
}
