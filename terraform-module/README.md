# Infrastructure-as-Code

This repository contains Infrastructure-as-Code (IaC) configurations for deploying AWS infrastructure using Terraform and CloudFormation.

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Modules](#modules)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This project provides automated infrastructure provisioning for AWS resources, primarily focused on EC2 and VPC setup. It combines Terraform modules for modular and reusable infrastructure components.

## 📁 Project Structure

```
.
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables definition
├── output.tf            # Output values definition
├── providers.tf         # Provider configuration (AWS)
├── userdata.tpl         # User data template for EC2 instances
├── ec2-vpc.yaml         # CloudFormation template for EC2 and VPC
└── module/
    ├── security/        # Security group module
    └── vpc/             # VPC module
```

## 🔧 Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads) (v1.0 or higher)
- [AWS CLI](https://aws.amazon.com/cli/) (v2.0 or higher)
- AWS account with appropriate permissions
- Git

## 📦 Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd aws-terraform/terraform-module
```

2. Initialize Terraform:
```bash
terraform init
```

3. Validate the configuration:
```bash
terraform validate
```

## ⚙️ Configuration

### Variables

Define your infrastructure parameters in `terraform.tfvars`:

```hcl
# Example terraform.tfvars
region              = "us-east-1"
environment         = "production"
instance_type       = "t2.micro"
availability_zones  = ["us-east-1a", "us-east-1b"]
```

Refer to `variables.tf` for all available configuration options.

### AWS Credentials

Configure AWS credentials using one of the following methods:

1. **AWS CLI Configuration**:
```bash
aws configure
```

2. **Environment Variables**:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

3. **AWS Profile**:
```bash
export AWS_PROFILE=your-profile
```

## 🚀 Deployment

### Plan

Preview the infrastructure changes:
```bash
terraform plan -out=tfplan
```

### Apply

Deploy the infrastructure:
```bash
terraform apply tfplan
```

### Destroy

Remove the infrastructure:
```bash
terraform destroy
```

## 📦 Modules

### VPC Module

Located in `module/vpc/`, this module manages Virtual Private Cloud resources:
- VPC creation
- Subnets (public and private)
- Internet Gateway
- NAT Gateway
- Route tables

### Security Module

Located in `module/security/`, this module manages security-related resources:
- Security groups
- Network ACLs
- Security group rules

## 📤 Outputs

The infrastructure exports the following outputs (see `output.tf`):
- VPC ID
- Subnet IDs
- Security Group IDs
- EC2 Instance details

Access outputs after deployment:
```bash
terraform output
```

## 🔐 Security Considerations

- Store sensitive data in `terraform.tfvars` and add it to `.gitignore`
- Use AWS IAM roles and policies with least privilege principle
- Enable VPC Flow Logs for monitoring
- Regularly update security group rules
- Use AWS Secrets Manager for sensitive values

## 🐛 Troubleshooting

### Terraform State

To check the current state:
```bash
terraform state list
terraform state show <resource>
```

### Common Issues

- **Provider not initialized**: Run `terraform init`
- **Invalid credentials**: Verify AWS credentials configuration
- **Permission denied**: Ensure IAM user has necessary permissions

## 📝 Contributing

1. Create a feature branch
2. Make your changes
3. Test the configuration
4. Submit a pull request


