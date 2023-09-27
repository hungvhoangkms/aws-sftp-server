output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "The ID of primary subnet"
  value       = aws_subnet.primary_subnet.id
}
output "hostname" {
  description = "The Host domain of SFTP server"
  value = aws_transfer_server.sftp.endpoint
}