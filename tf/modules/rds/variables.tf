variable "db_name" { type = string }
variable "db_class" { type = string }
variable "multi_az" { type = bool }
variable "subnet_ids" { type = list(string) }
variable "vpc_id" { type = string }
variable "environment" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}   