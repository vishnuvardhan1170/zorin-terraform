environment         = "prod"
aws_region          = "ap-south-1"
node_count          = 3
node_instance_types = ["t3.large"]
db_instance_class   = "db.t3.small"
db_multi_az         = true
argocd_admin_password = "changeme-prod"   