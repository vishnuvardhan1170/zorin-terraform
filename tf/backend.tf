terraform {
  backend "s3" {
    bucket         = "zorin-terraform-state"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "zorin-terraform-locks"
    encrypt        = true
  }
}