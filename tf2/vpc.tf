module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.14.0"
  name            = var.name_prefix
  cidr            = var.vpc_cidr
  azs             = var.aws_azs
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs
  # NAT is disabled to save money, as the private subnets are currently not used.
  enable_nat_gateway   = false
  enable_dns_hostnames = true
  tags                 = var.global_vpc_tags
  private_subnet_tags  = var.private_subnet_tags
  public_subnet_tags   = var.public_subnet_tags
}

// Output VPC values to allow this statefile to be used as a datasource
output "aws_vpc_private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "aws_vpc_public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "aws_vpc_id" {
  value = module.vpc.vpc_id
}

output "aws_vpc_cidr" {
  value = var.vpc_cidr
}

output "aws_nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "aws_vpc_private_subnet_cidrs" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "aws_vpc_public_subnet_cidrs" {
  value = module.vpc.public_subnets_cidr_blocks
}
