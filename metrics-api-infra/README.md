# Terraform confogs for metrics api app

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- An AWS account with the necessary permissions to create resources

## Getting Started

### Update Variables
1. Copy the `terraform.tfvars.example` file to `terraform.tfvars`
```bash
cp terraform.tfvars.example terraform.tfvars
```
2. Edit the `terraform.tfvars` file to include your specific variable values. You will need to set the AWS region, key pair name, and any other required variables.

### Initialize Terraform
Initialize the Terraform project. This will download the necessary provider plugins:
```bash
terraform init
```

### Plan the Deployment
Generate an execution plan. This will show you the resources that Terraform will create, update, or delete:

```bash
terraform plan
```

### Apply the Deployment
Apply the Terraform configuration to create the resources:

```bash
terraform apply
```
Type `yes` when prompted to confirm the operation.

### Cleaning Up
To destroy the resources created by Terraform, run:

```bash
terraform destroy
```
Type `yes` when prompted to confirm the operation.

## Files in This Repository

- `main.tf`: Main Terraform configuration file.
- `provider.tf`: Provider configuration file.
- `variables.tf`: Variable definitions.
- `terraform.tfvars.example`: Example variable values.
