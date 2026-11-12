# zorin-terraform

Infrastructure-as-Code for the zorin DevOps pipeline. Provisions VPC, GKE, Artifact Registry, and ArgoCD in GCP (asia-south1) using Terraform modules.

## What it provisions

| Module | Resources |
|--------|-----------|
| `vpc` | 1 region, 1 subnet with pod + service secondary IP ranges |
| `gke` | GKE cluster (e2-medium nodes), identity namespace enabled for WIF |
| `artifact-registry` | Docker repository (`zorin`) in asia-south1 |
| `argocd` | ArgoCD 7.3.0 + Argo Rollouts 1.7.0 via Helm, LoadBalancer ingress |

## Auth model

- **No long-lived GCP keys** in GitHub secrets.
- GitHub OIDC → Workload Identity Federation (WIF) → IAM service accounts scoped by `repo:org/repo`.
- Three SAs: `ci-bot` (image push), `deploy-bot` (gitops), `tf-bot` (terraform apply).

## State & locking

- Backend: GCS (`zorin-terraform-state`), prefix per environment.
- Encrypted at rest (GCS default encryption).

## CI/CD (GitHub Actions)

| Workflow | Trigger | Action |
|----------|---------|--------|
| `terraform-plan.yaml` | Push to main | `fmt` → `validate` → `plan` → PR comment |
| `terraform-apply.yaml` | Push to main | `init` → `apply -auto-approve` |

## Local bootstrap (one-time)

```bash
# 1. Create backend bucket
gsutil mb -c asia-south1 gs://zorin-terraform-state

# 2. First apply (creates WIF pool + SAs for future CI runs)
cd tf
terraform init -backend-config="bucket=zorin-terraform-state" \
  -backend-config="prefix=prod"
terraform apply -auto-approve -var-file=environments/prod/terraform.tfvars
```

Project structure
```
├── README.md
├── tf/
│   ├── backend.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── iam.tf
│   ├── outputs.tf
│   ├── environments/
│   │   ├── dev/terraform.tfvars
│   │   └── prod/terraform.tfvars
│   └── modules/
│       ├── vpc/
│       ├── gke/
│       ├── artifact-registry/
│       └── argocd/
└── .github/workflows/
    ├── terraform-plan.yaml
    └── terraform-apply.yaml
    ```