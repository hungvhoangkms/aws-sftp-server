variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "sftp"
}
variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "primary_subnet" {
  description = "The IPv4 CIDR block for the primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "create_public_subnets" {
  type        = bool
  description = "Enable to public the primary subnet"
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "sftp_users" {
  description = "Configuration for the sftp user"
  type = list(object({
    customer_name : string
    customer_number : number
    authenticate_method : object({
      ssh_public_key : string
      password : string
    })
    bucket_names : list(string)
  }))
  default = [{
    authenticate_method ={
      ssh_public_key = "lkjasdlf"
      password = "l;kajsd;f"
    }
    bucket_names = [ "hung-smtp-bucket-1","hung-smtp-bucket-2" ]
    customer_name = "hung"
    customer_number = 231
  },
  {
    authenticate_method ={
      ssh_public_key = "lkjasdlf"
      password = "l;kajsd;f"
    }
    bucket_names = [ "hung-smtp-bucket-1" ]
    customer_name = "hy"
    customer_number = 123
  }]
}

variable "username" {
  type = string
  default = "hung"
}
