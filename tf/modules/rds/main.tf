resource "aws_db_subnet_group" "this" {
  name       = "zorin-rds-${var.environment}"
  subnet_ids = var.subnet_ids
}

resource "aws_db_security_group" "this" {
  name        = "zorin-rds-${var.environment}"
  description = "RDS security group for zorin"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = []
    cidr_blocks     = var.subnet_ids # restrict to VPC; tighten to EKS SG in prod
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "this" {
  identifier     = "zorin-${var.environment}"
  engine         = "postgres"
  engine_version = "16.3"
  instance_class = var.db_class
  allocated_storage = 20
  max_allocated_storage = 100
  db_name            = var.db_name
  username           = "zorin"
  password           = var.db_password
  multi_az           = var.multi_az

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_db_security_group.this.id]

  storage_encrypted = true
  storage_type      = "gp3"
  iops              = 3000

  backup_retention_period = var.environment == "prod" ? 7 : 1
  skip_final_snapshot     = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "zorin-final" : null

  tags = {
    Environment = var.environment
  }
}   