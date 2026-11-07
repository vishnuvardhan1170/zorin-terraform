variable "cluster_name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_count" { type = number }
variable "node_types" { type = list(string) }
variable "environment" { type = string }
variable "ecr_repo_url" { type = string }
variable "ecr_readonly_policy_arn" { type = string }