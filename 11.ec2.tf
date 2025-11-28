#Linux Private Server - London
resource "aws_instance" "Linux_Private" {
  ami           = data.aws_ami.linux_ami.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_subnet[0].id
  user_data = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.Linux_Server_London.id]

  tags = {
    Name = "Linux Private Server"
  }
}

#Linux Public Server - London
resource "aws_instance" "Linux_Public" {
  ami           = data.aws_ami.linux_ami.id
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.public_subnet[2].id
  user_data = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.Linux_Server_London.id]

  tags = {
    Name = "Linux Public Server"
  }
}

#Linux Private Server - Dubai
resource "aws_instance" "Linux_Private_Dubai" {
  ami           = data.aws_ami.dubai_ami.id
  instance_type = "t3.micro"
  provider      = aws.Dubai

  subnet_id = aws_subnet.private_subnet_Dubai[0].id
  user_data = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.Linux_Server_Dubai.id]

  tags = {
    Name = "Linux Private Server Dubai"
  }
}

#Linux Public Server - Dubai
resource "aws_instance" "Linux_Public_Dubai" {
  ami           = data.aws_ami.dubai_ami.id
  instance_type = "t3.micro"
  associate_public_ip_address = true
  provider      = aws.Dubai

  subnet_id = aws_subnet.public_subnet_Dubai[2].id
  user_data = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.Linux_Server_Dubai.id]

  tags = {
    Name = "Linux Public Server Dubai"
  }
}