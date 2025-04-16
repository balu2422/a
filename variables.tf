variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnet_1_cidr" {}
variable "public_subnet_1_az" {}
variable "public_subnet_2_cidr" {}
variable "public_subnet_2_az" {}
variable "public_subnet_3_cidr" {}
variable "public_subnet_3_az" {}
variable "sg_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "instance_name" {}
variable "alb_name" {}
variable "target_groups" {
  type = list(string)
}
variable "target_group_attachments" {
  type = list(object({
    target_group_arn = string
    target_id = string
  }))
}
variable "listener_rules" {
  type = list(object({
    priority = number
    path = string
    target_group_arn = string
  }))
}
