terraform {
  backend "s3" {
    # Pre-create these before first `terraform init`:
    #   aws s3api create-bucket --bucket zorin-terraform-state --region ap-south-1
    #   aws dynamodb create-table --table-name zorin-terraform-locks \
    #     --attribute-definitions AttributeName=LockID,AttributeType=S \
    #     --key-schema AttributeName=LockID,KeyType=HASH \
    #     --billing-mode PAY_PER_REQUEST
    bucket         = "zorin-terraform-state"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "zorin-terraform-locks"
    encrypt        = true
  }
}