variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "zorin"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_instance_types" {
  description = "EKS node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_count" {
  description = "Number of EKS nodes"
  type        = number
  default     = 1
}

variable "github_org" {
  description = "GitHub organization"
  type        = string
  default     = "vishnuvardhan1170"
}

variable "github_repo" {
  description = "GitHub repository"
  type        = string
  default     = "zorin-infra"
}

# --- RDS ---
variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "zorin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_multi_az" {
  description = "Enable multi-AZ for RDS"
  type        = bool
  default     = false
}

# --- ArgoCD ---
variable "argocd_admin_password" {
  description = "ArgoCD admin password"
  type        = string
  sensitive   = true
}   