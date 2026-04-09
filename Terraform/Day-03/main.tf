provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance" #importing from modules/ec2_instance to create ec2 instance
  ami_value = "ami-ID" # replace this
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-ID" # replace this
}