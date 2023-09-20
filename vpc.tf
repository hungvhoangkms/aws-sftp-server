# Create a VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "security_group" {
  name   = "$Allow-ssh-sg"
  vpc_id = aws_vpc.main.id

}

resource "aws_security_group_rule" "default_sg_rule" {
  security_group_id = aws_security_group.security_group.id
  description       = "Default ingress from VPC"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

}