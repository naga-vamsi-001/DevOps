provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-0ec10929233384c7f"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-00a759e414ba005a0"
    key_name = "Ansible_key"
}