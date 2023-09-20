resource "aws_eip" "public_ip" {
  domain   = "vpc"
}


resource "aws_transfer_server" "sftp" {
#   endpoint_type          = "VPC"
  protocols              = ["SFTP"]
#   identity_provider_type = "SERVICE_MANAGED"
#   domain                 = "S3"
  

#   endpoint_details {
#     subnet_ids             = [aws_subnet.main.id]
#     vpc_id                 = aws_vpc.main.id
#     security_group_ids     = [aws_security_group.security_group.id]
#     address_allocation_ids = [aws_eip.public_ip.id]
#   }

#   force_destroy        = true

}


