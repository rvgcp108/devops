variable "ami_id" {
  type        = string
  description = "aws ami id to create instance"
}

variable "instance_type" {
  type        = string
  description = "Favorite instance type"
}

variable "key_name" {
  type        = string
  description = "Favorite key name"
}

variable "env" {
  type        = string
  description = "env name"
}
