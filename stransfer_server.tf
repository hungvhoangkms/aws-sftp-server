resource "aws_eip" "public_ip" {
  count = var.create_public_subnets ? 1 : 0
  domain   = "vpc"
}

resource "aws_security_group" "security_group" {
  name   = "$Allow-ssh-sg"
  vpc_id = aws_vpc.this.id

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

resource "aws_transfer_server" "sftp" {
  endpoint_type          = "VPC"
  protocols              = ["SFTP"]
  identity_provider_type = "SERVICE_MANAGED"
  domain                 = "S3"


  endpoint_details {
    subnet_ids             = [aws_subnet.primary_subnet.id]
    vpc_id                 = aws_vpc.this.id
    security_group_ids     = [aws_security_group.security_group.id]
    address_allocation_ids = var.create_public_subnets ? [aws_eip.public_ip[0].id] : []
  }

  force_destroy = true

}


