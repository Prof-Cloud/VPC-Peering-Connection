#!/bin/bash
# Update & install Apache for Amazon Linux
yum update -y
yum install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# --- Get IMDSv2 token ---
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" -s)

# --- Get instance metadata ---
HOSTNAME=$(hostname -f)

AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

MAC=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/network/interfaces/macs/ | sed 's|/$||')

VPC_CIDR=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC}/vpc-ipv4-cidr-block)

# --- Create simple webpage ---
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Hello from EC2</title>
</head>
<body>
<h1>Hi! My name is ${HOSTNAME}</h1>
<p>My VPC CIDR range is: <b>${VPC_CIDR}</b></p>
<p>I am running in Availability Zone: <b>${AZ}</b></p>
<br>
<h2>Welcome to Prof Cloud!</h2>
</body>
</html>
EOF

# Ensure httpd is listening immediately
systemctl restart httpd
