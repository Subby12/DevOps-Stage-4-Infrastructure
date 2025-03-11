# Security group for the application
resource "aws_security_group" "instance_sg" {
  name        = "${var.app_name}-${var.environment}-sg"
  description = "Security group for ${var.app_name} in ${var.environment}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-sg"
    Application = var.app_name
    Environment = var.environment
  }
}

# EC2 instance for the application
resource "aws_instance" "app_instance" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  
  tags = {
    Name        = "${var.app_name}-${var.environment}"
    Application = var.app_name
    Environment = var.environment
  }
  
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  # Ensure the instance gets a public IP
  associate_public_ip_address = true
}