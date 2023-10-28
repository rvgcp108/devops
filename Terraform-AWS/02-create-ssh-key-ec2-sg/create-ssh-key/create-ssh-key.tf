### First create public and private keys using this command ssh-keygen -t rsa
### Create SSH key resource

resource "aws_key_pair" "dev-key" {
  key_name   = "login-key"
  public_key = file("${path.module}/ssh-key.pub")

}
