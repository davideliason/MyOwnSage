resource "aws_vpc" "main-vp" {
  cidr_block             = var.cidr_block
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support

  tags = var.tags
}
