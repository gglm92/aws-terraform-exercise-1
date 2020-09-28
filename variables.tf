variable "aws_region" {
    type        = string
    description = "AWS Region"
}

variable "aws_access_key" {
    type        = string
    description = "AWS Access Key"
}

variable "aws_secret_key" {
    type        = string
    description = "AWS Secret Key"
}

variable "private_key_path" {
    type        = string
    description = "Private key path to connect ec2 machines"
}

variable "private_key_file" {
    type        = string
    description = "Private key file to connect ec2 machines"
}

variable "vpc_name" {
    type        = string
    description = "VPC name"
}

variable "vpc_cidr_block" {
    type        = string
    description = "cidr block for VPC"
}

variable "subnet_1a_name" {
    type        = string
    description = "Subnet1 name"
}

variable "subnet_1a_cidr_block" {
    type        = string
    description = "cidr block for Subnet1"
}

variable "subnet_1a_az" {
    type        = string
    description = "Availability zone for subnet1"
}

variable "subnet_1b_name" {
    type        = string
    description = "Subnet2 name"
}

variable "subnet_1b_cidr_block" {
    type        = string
    description = "cidr block for Subnet2"
}

variable "subnet_1b_az" {
    type        = string
    description = "Availability zone for subnet2"
}

variable "subnet_public" {
    type        = string
    description = "Public subnet name"
}

variable "subnet_public_cidr_block" {
    type        = string
    description = "cidr block for public subnet"
}

variable "subnet_public_az" {
    type        = string
    description = "Availability zone for public subnet"
}

variable "subnet_public_nat1" {
    type        = string
    description = "Public subnet name"
}

variable "subnet_public_cidr_block_nat1" {
    type        = string
    description = "cidr block for public subnet"
}

variable "subnet_public_az_nat1" {
    type        = string
    description = "Availability zone for public subnet"
}

variable "subnet_public_nat2" {
    type        = string
    description = "Public subnet name"
}

variable "subnet_public_cidr_block_nat2" {
    type        = string
    description = "cidr block for public subnet"
}

variable "subnet_public_az_nat2" {
    type        = string
    description = "Availability zone for public subnet"
}

variable "route_table_public_name" {
    type        = string
    description = "Public route table name"
}

variable "route_table_public_private_name" {
    type        = string
    description = "Private-Public route table name"
}

variable "security_group_name" {
    type        = string
    description = "Security group name"
}

variable "security_group_description" {
    type        = string
    description = "Security group description"
}

variable "instance_ami_bastion" {
    type        = string
    description = "Amazon Machine Image"
}

variable "instance_type_bation" {
    type        = string
    description = "Bastion EC2 machine type"
}

variable "instance_ami" {
    type        = string
    description = "Amazon Machine Image"
}

variable "instance_type" {
    type        = string
    description = "EC2 machine type"
}

variable "instance_key_name" {
    type        = string
    description = "Key name to use on ec2 machines"
}

variable "instance_tag_type" {
    type        = string
    description = "Tag type to add to ec2 machines"
    default     = "ec2instance"
}

variable "security_group_web_name" {
    type        = string
    description = "Security group name"
}

variable "security_group_web_description" {
    type        = string
    description = "Security group description"
}

variable "target_group_name" {
    type        = string
    description = "Target group name"
}

variable "lb_name" {
    type        = string
    description = "Load Balancer name"
}