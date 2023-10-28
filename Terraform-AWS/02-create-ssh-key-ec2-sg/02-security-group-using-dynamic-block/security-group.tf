
### Create a Security group
resource "aws_security_group" "allow-tcp" {
  name        = "allow tcp"
  description = "Allow Inbound Traffic for Multiple protocols"

  dynamic "ingress" {
    for_each = [22, 443, 80, 3306]
    iterator = port
    ### Content for Ingress rules
    content {
      description = "TLS for the VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
