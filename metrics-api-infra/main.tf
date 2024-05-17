resource "aws_instance" "matrics_app" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  security_groups = ["docker-ports-sg"]
  associate_public_ip_address = true
  key_name = var.ec2_key_name

  tags = {
    Name = "metrics-app-machine"
  }
}

resource "aws_security_group" "docker_ports" {
  name        = "docker-ports-sg"
  description = "Security group for Docker ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
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
