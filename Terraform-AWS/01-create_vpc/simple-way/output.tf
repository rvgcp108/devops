output "vpc_id" {
  value = aws_vpc.prod.id
}

output "vpc_cidr" {
  value = aws_vpc.prod.cidr_block
}

output "ami" {
  value = data.aws_ami.ubuntu
}

output "aws_route_table" {
  value = aws_internet_gateway.gw.id
}
output "IGW" {
  value = aws_internet_gateway.gw.id

}