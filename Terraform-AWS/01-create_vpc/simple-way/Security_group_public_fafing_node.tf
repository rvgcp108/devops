# Creating a Security Group for public facing node
resource "aws_security_group" "WS-SG" {

  depends_on = [
    aws_vpc.prod
  ]

  description = "HTTP, PING, SSH"

  # Name of the security Group!
  name = "container-sg"

  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.prod.id

  # Created an inbound rule for webserver access!
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80

    # Here adding tcp instead of http, because http in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for ping
  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outward Network Traffic for the WordPress
  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}