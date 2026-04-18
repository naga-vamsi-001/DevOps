terraform {
  backend "s3" {
    bucket         = "Naga-s3-demo-xyz" # change this
    key            = "Naga/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}