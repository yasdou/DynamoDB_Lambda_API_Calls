
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "MyVPC"
  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true


  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  public_subnet_names = ["Public Subnet One", "Public Subnet Two"]
  database_subnets= ["10.0.21.0/24", "10.0.22.0/24"]
  database_subnet_names = ["Database Subnet One", "Database Subnet Two"]

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true

  #create one NAT Gateway for all private subnets. For higher availabilty turn single_nat_gateway 
  #to false (creates one NAT Gateway per subnet) or set single_nat_gateway to false and 
  #one_nat_gateway_per_az to true (creates one Gateway per AZ)
  enable_nat_gateway = false
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  create_igw = true

#   enable_vpn_gateway = true

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${var.name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${var.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${var.name}-default" }

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# module "vpc_endpoints" {
#   source = "terraform-aws-modules/vpc/aws/modules/vpc-endpoints"

#   vpc_id             = module.vpc.vpc_id
#   security_group_ids = [data.aws_security_group.default.id]

# endpoints = {
#     dynamodb = {
#     service         = "dynamodb"
#     service_type    = "Gateway"
#     route_table_ids = [module.vpc.private_route_table_ids]
#     policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
#     tags            = { Name = "dynamodb-vpc-endpoint" }
#     },
#     ec2 = {
#       service             = "ec2"
#       private_dns_enabled = true
#       subnet_ids          = module.vpc.private_subnets
#       security_group_ids  = [aws_security_group.vpc_tls.id]
#     },
# }
# }

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}