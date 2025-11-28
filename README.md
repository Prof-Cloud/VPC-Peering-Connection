# VPC-Peering-Connection

In this project, I created a VPC Peering Connection between 2 AWS regions: London and Dubai. 

I created everything using Terraform, including the VPCs, subnets, route tables, and the peering connection. I also created 2 security groups and 4 EC2 instances, 2 in London and 2 in Dubai, so I could test the network. I used a public EC2 instance in London to reach a private EC2 instance in Dubai, and then I tested it the other way around too. This helped me confirm that the peering connection was working correctly in both directions. 

<img width="2520" height="1740" alt="Blank diagram" src="https://github.com/user-attachments/assets/bacba93c-e576-4851-8849-42d87e948bb2" />

## Highlighting the Important Features

1. Two Custom VPCs - I made 2 VPCs using a CIDR range that I chose.
   - London VPC
   - Dubai VPC
  
   Inside this, I made:
  - public subnets
  - private subnets

2. VPC Peering Connection - I created a VPC peering link between London and Dubai so both VPCs could communicate directly using Private IPs. The peering is bi-directional, meaning traffic can go:
     - London -> Dubai
     - Dubai -> London

4. Route Tables - I created a NAT gateway in the public subnet and attached an Elastic IP to it. This lets the private Linux server connect outbound to the internet, but it still stay hidden and cannot be reached from the outside.

5. Route tables - I made 2 different route tables:
    - Public Route Table
        - Sends all traffic to the Internet Gateway
        - Connected to the public subnets
        - Routing traffic to Dubai/London CIDR into VPC Peering Connection
          
    - Private Route Table
        - Sends all traffic to the NAT Gateway
        - Connected to the private subnets
        - Routing traffic to Dubai/London CIDR into VPC Peering Connection

6. Security Groups - I create security groups for each region:   
    - Linus Server (London Region)
        - Allow SSH (port 22)
        - Allow HTTP (port 80)
        - Allow ICMP from Dubai VPC CIDR
        - Allow HTTP from Dubai VPC

  - Linus Server (Dubai Region)
        - Allow SSH (port 22)
        - Allow HTTP (port 80)
        - Allow ICMP from London VPC CIDR
        - Allow HTTP from London VPC
          
7. EC2 Instances - I launched 4 EC2 instances total:

   - London Server 
       - Public EC2 (testing origin)
       - Private EC2

    - London Server 
       - Public EC2 (testing origin)
       - Private EC2

8. Connectivity Testing - I tested traffic both ways:

   - London public instance -> Dubai private instance
   - Dubai public instance -> London private instance
           
  ## Alternatives You Could Use Instead

  1. AWS Transit Gateway
       - Better for large networks
       - Supports many PCs in a hub and spoke design
       - Simplier routing and scaling
         
  2. AWS VPN (Site-to-Site VPN)
      - Uses encrypted tunnels
      - Works across regions and hybrif environemnt

  3. AWS PrivateLink
       - Good if you only want to expose specific services, not whole VPCs

## Improvements I Can Add Later

1. Lock down security groups more tightly
2. Add VPC flow logs in both VPCs to watch traffic between them 
3. Add VPC endpoints for private access to AWS services.
4. Use Transit Gateway to scale if more regions or VPCs are added
5. Add more automation in Terraform to make modules for reuse 


