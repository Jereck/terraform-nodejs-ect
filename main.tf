provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "node_server_sg" {
  name        = "node-server-sg"
  description = "Allow inbound HTTP traffic on port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "node_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.node_server_sg.name]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Node.jsServer"
  }
}
