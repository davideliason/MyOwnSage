resource "aws_vpc" "main-vpc" {
  cidr_block                 = var.cidr_block
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_dns_support         = var.enable_dns_support

  tags = var.tags
}

 resource "aws_subnet" "public_subnet-1" {
  vpc_id                     = aws_vpc.main-vpc.id
  cidr_block                 = cidrsubnet(aws_vpc.main-vpc.cidr_block, 4,1)
  availability_zone          = "us-west-2a"

  tags = {
    Name = "MoS-public-SN-us-west-2a"
  }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id                    = aws_vpc.main-vpc.id
  cidr_block                = cidrsubnet(aws_vpc.main-vpc.cidr_block, 4,2)
  availability_zone         = "us-west-2a"

  tags = {
    Name = "MoS-private-SN-us-west-2a"
  }
}

resource "aws_internet_gateway" "MoS-IGW" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "Mos-main-VPC-IGW"
  }
}
