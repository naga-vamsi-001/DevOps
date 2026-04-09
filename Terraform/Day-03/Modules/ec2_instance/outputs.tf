output "public-ip-address" {
  value = aws_instance.example.public_ip #print's the public_ip address in terminal
}