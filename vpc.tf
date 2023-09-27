resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}
resource "aws_subnet" "primary_subnet" {
  cidr_block = var.primary_subnet
  vpc_id     = aws_vpc.this.id

  tags = merge(
    {
    Name = "${var.name}-primary_subnet" },
    var.tags,
  )
}

resource "aws_internet_gateway" "this" {
  count = var.create_public_subnets ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}
resource "aws_route_table" "public" {
  count = var.create_public_subnets ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
  )
}

resource "aws_route_table_association" "public" {
  count          = var.create_public_subnets ? 1 : 0
  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_public_subnets ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

