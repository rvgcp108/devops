variable "cidr-block" {
  type        = string
  description = "Prod VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "environment" {
  type        = string
  description = "environment"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "configuration" {
  description = "The total configuration, List of Objects/Dictionary"
  default     = [{}]
}