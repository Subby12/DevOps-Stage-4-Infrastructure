variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "private_key_path" {
  description = "Path to private SSH key"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "todo-app"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "prod"
}
