variable "env" {
  default = "Environment name"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR (Classless inter-domain routing)"
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "Avalibility zones for subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "CIDR ranges for private subnets"
  type = list(string)
}

variable "public_subnets" {
  description = "CIDR ranges for public subnets"
  type = list(string)
}

variable "private_subnet_tags" {
  description = "private subnet tags"
  type = map(any)
}
variable "public_subnet_tags" {
  description = "public subnet tags"
  type = map(any)
}

# LB health check path
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

variable "amis" {
  description = "Which AMI"
  default = {
    us-west-2 = "ami-0b2b4f610e654d9ac"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "terraform-test"
}

