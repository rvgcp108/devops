env = "prod"
vpc_cidr_block ="10.0.0.0/16"
azs = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
public_subnets = ["10.0.3.0/24","10.0.4.0/24"]
private_subnet_tags = {Name = "Public_seubnet"}
public_subnet_tags = {Name = "Private_seubnet"}