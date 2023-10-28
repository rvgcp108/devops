cidr-block           = "10.0.0.0/24"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
azs                  = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
environment          = "production"
####
configuration = [
  {
    "application_name" : "dev1",
    "ami" : "ami-09e67e426f25ce0d7",
    "no_of_instances" : "2",
    "instance_type" : "t2.micro",
    "subnet_id" : "subnet-0f4f294d8404946eb",
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c","sg-0d8749c35f7439f3e"]
  },
  {
    "application_name" : "dev2",
    "ami" : "ami-0747bdcabd34c712a",
    "instance_type" : "t2.micro",
    "no_of_instances" : "1"
    "subnet_id" : "subnet-0f4f294d8404946eb"
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c"]
  },
  {
    "application_name" : "OpsGrit-dev",
    "ami" : "ami-0747bdcabd34c712a",
    "instance_type" : "t3.micro",
    "no_of_instances" : "3"
    "subnet_id" : "subnet-0f4f294d8404946eb"
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c"]
  }
]


