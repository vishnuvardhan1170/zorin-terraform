# zorin-terraform

Infrastructure-as-Code for the zorin DevOps pipeline. Provisions VPC, EKS, ECR, and ArgoCD in AWS (ap-south-1) using Terraform modules.

## What it provisions

| Module | Resources |
|--------|-----------|
| `vpc` | 2 AZs, 2 public + 2 private subnets, 1 NAT GW |
| `eks` | EKS v1.33, managed node group (t4g.medium), IRSA enabled |
| `ecr` | Repository with immutable tags + scan-on-push |
| `argocd` | ArgoCD 7.3.0 via Helm, NodePort 30081 |

## Auth model

- **No long-lived AWS keys** in GitHub secrets.
- GitHub OIDC → IAM roles scoped by `repo:org/repo:ref:refs/heads/main`.
- Two roles: `github-actions-terraform` (apply) and `github-actions-ecr-push` (image push, used by zorin-app CI).

## State & locking

- Backend: S3 (`zorin-terraform-state`) + DynamoDB (`zorin-terraform-locks`).
- Encrypted at rest.

## CI/CD (GitHub Actions)

| Workflow | Trigger | Action |
|----------|---------|--------|
| `terraform-plan.yaml` | PR to main | `fmt` → `validate` → `plan` → comment on PR |
| `terraform-apply.yaml` | Push to main | `init` → `apply -auto-approve` |

## Local bootstrap (one-time)

```bash
# 1. Create backend resources
aws s3api create-bucket --bucket zorin-terraform-state --region ap-south-1
aws dynamodb create-table --table-name zorin-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

# 2. First apply (creates the OIDC role for future CI runs)
cd tf
terraform init -backend-config="key=prod/terraform.tfstate" \
  -backend-config="bucket=zorin-terraform-state" \
  -backend-config="region=ap-south-1" \
  -backend-config="dynamodb_table=zorin-terraform-locks"
terraform apply -auto-approve -var-file=environments/prod/terraform.tfvars