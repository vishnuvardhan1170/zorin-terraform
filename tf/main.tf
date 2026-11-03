module "vpc" {
  source = "./modules/vpc"

  name        = "${var.cluster_name}-vpc"
  cidr        = var.vpc_cidr
  region      = var.aws_region
  cluster_name = var.cluster_name
  environment = var.environment
}

module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  node_count   = var.node_count
  node_types   = var.node_instance_types
  environment  = var.environment
}

module "rds" {
  source = "./modules/rds"

  db_name      = var.db_name
  db_class     = var.db_instance_class
  multi_az     = var.db_multi_az
  subnet_ids   = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "zorin"
}

module "alb" {
  source = "./modules/alb"

  cluster_name = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca_data  = module.eks.cluster_certificate_authority_data
  oidc_provider_arn = module.eks.oidc_provider_arn
  vpc_id       = module.vpc.vpc_id
  region       = var.aws_region
}

module "argocd" {
  source = "./modules/argocd"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_ca_data   = module.eks.cluster_certificate_authority_data
  oidc_provider_arn = module.eks.oidc_provider_arn
  vpc_id            = module.vpc.vpc_id
  region            = var.aws_region
  admin_password    = var.argocd_admin_password
  ingress_host      = "argocd.${var.environment}.zorin.example.com"
}   