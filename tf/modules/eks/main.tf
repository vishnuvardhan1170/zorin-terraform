module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.19"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.33"
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 30
  }

  eks_managed_node_groups = {
    nodes = {
      min_size       = var.node_count
      max_size       = var.node_count
      desired_size   = var.node_count
      instance_types = var.node_types
      # capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = var.environment
  }
}