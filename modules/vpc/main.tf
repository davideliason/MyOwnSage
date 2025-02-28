resource "aws_vpc" "main-vpc" {
  cidr_block                 = var.cidr_block
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_dns_support         = var.enable_dns_support

  tags = var.tags
}

 resource "aws_subnet" "public_subnet-1" {
  vpc_id                     = aws_vpc.main-vpc.id
  cidr_block                 = cidrsubnet(aws_vpc.main-vpc.cidr_block, 4, 0)
  availability_zone          = "us-west-2a"

  tags = {
    Name = "MoS-public-SN-us-west-2a"
  }
}

#add second public subnet in a different AZ for failover, redundancy

resource "aws_subnet" "public_subnet-2" {
  vpc_id                    = aws_vpc.main-vpc.id
  cidr_block                = cidrsubnet(aws_vpc.main-vpc.cidr_block,4,2)
  availability_zone         = "us-west-2b"

  tags = {
    Name = "MoS-public_SN-us-west-2b"
 }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id                    = aws_vpc.main-vpc.id
  cidr_block                = cidrsubnet(aws_vpc.main-vpc.cidr_block, 4,1)
  availability_zone         = "us-west-2a"

  tags = {
    Name = "MoS-private-SN-us-west-2a"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = cidrsubnet(aws_vpc.main-vpc.cidr_block, 4, 3) #10.16.48.0/2

  availability_zone       = "us-west-2b"             
  map_public_ip_on_launch = false

  #add custom tags
  tags = {
    Name = "Mos-private-SN-us-west-2b"  
  }
}
resource "aws_internet_gateway" "MoS-IGW" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "Mos-main-VPC-IGW"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id                    = aws_vpc.main-vpc.id
  
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.MoS-IGW.id
   }

    tags = {
      Name = "MoS-public-RT"
  }
}

# associate the public RT to the public subnet
resource "aws_route_table_association" "public-subnet-association-1" {
  subnet_id                 = aws_subnet.public_subnet-1.id
  route_table_id            = aws_route_table.public-route-table.id
}

# associate second public SN with public RT for IGW access
resource "aws_route_table_association" "public-subnet-association-2" {
  subnet_id                 = aws_subnet.public_subnet-2.id
  route_table_id            = aws_route_table.public-route-table.id
}
