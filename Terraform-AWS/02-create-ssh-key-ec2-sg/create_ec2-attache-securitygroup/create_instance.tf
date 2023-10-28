### First create public and private keys using this command ssh-keygen -t rsa
### Create SSH key resource

#resource "aws_key_pair" "dev-key" {
#  key_name   = "login-key"
#  public_key = file("${path.module}/ssh-key.pub")

#}


### Create a instance 
resource "aws_instance" "web1" {
  ami           = "ami-0fcf52bcf5db7b003"
  instance_type = "t2.micro"
  #key_name      = aws_key_pair.dev-key.key_name
  key_name      = "login-key"
  ###Attached security group to instance
  vpc_security_group_ids = ["${aws_security_group.allow-tcp.id}"]
  tags = {
    Name = "dev-web1"
  }


}
