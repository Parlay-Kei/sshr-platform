# SSHR Platform Infrastructure
# This is a placeholder for the main Terraform configuration

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Backend configuration will be set via CLI
  # terraform init -backend-config="bucket=sshr-tf-state"
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "sshr-platform"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "sshr-platform"
}

# Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = "placeholder"
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = "placeholder"
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = "placeholder"
} 