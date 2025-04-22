output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.node_server.public_ip
}

output "elastic_ip" {
  description = "Elastic IP address of the EC2 instance"
  value       = aws_eip.node_server_eip.public_ip
}