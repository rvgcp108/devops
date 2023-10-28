### Create a instance 
resource "aws_instance" "web1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  ###Attached security group to instance
  vpc_security_group_ids = ["${aws_security_group.allow-tcp.id}"]
  tags = {
    Name = "${var.env}"
  }


}
