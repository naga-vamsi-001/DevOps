provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Naga" {
  instance_type = "t2.micro"
  ami = "ami-ID" # change this
  subnet_id = "Subnet-ID" # change this
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "Naga-s3-demo-xyz" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "Y"
  }
}