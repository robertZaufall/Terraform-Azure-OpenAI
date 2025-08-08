# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains Terraform infrastructure code to deploy Azure OpenAI models across multiple regions. The system creates dedicated Cognitive Services accounts for each region and deploys various OpenAI models including GPT-4, O1, O3, O4, DALL-E-3, GPT-Image-1, and Whisper.

## Architecture

The Terraform configuration uses a data-driven approach:

- **Model Configuration**: Models are defined in `terraform.tfvars` as a list of objects containing name, model, version, capacity, and region
- **Multi-Region Deployment**: Automatically creates Cognitive Services accounts in each unique region specified in the models list
- **Resource Naming**: Uses consistent naming patterns with region suffixes (e.g., `openaitest-east-us` for non-default regions)
- **Backend State**: Configured for Azure Storage backend with credentials template in `config.azurerm.empty.tfbackend`

## Key Files

- `main.tf`: Core resource definitions for resource groups, cognitive accounts, and model deployments
- `variables.tf`: Variable definitions for build numbers, cognitive account name, and models array
- `terraform.tfvars`: Model configurations and deployment parameters
- `provider.tf`: Azure provider configuration with authentication via `azure_credentials.json`
- `data.tf`: Output definitions for endpoints and access keys
- `config.azurerm.tfbackend`: Backend configuration for state storage

## Common Commands

### Azure Authentication
```bash
# Login to Azure
az login

# Set subscription
az account set --subscription "{subscription}"

# Create service principal credentials
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/{subscription}" --sdk-auth > azure_credentials.json

# Alternative: Copy azure_credentials.empty.json to azure_credentials.json and fill in values
cp azure_credentials.empty.json azure_credentials.json
```

### Terraform Operations
```bash
# Initialize with backend configuration
terraform init -backend-config="config.azurerm.tfbackend" -upgrade

# Standard Terraform workflow
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy

# Get outputs
terraform output endpoint
terraform output primary_access_key
```

### Troubleshooting
```bash
# List soft-deleted cognitive services
az rest --method get --url "https://management.azure.com/subscriptions/{subscription}/providers/Microsoft.CognitiveServices/deletedAccounts?api-version=2021-04-30"

# View Terraform state
terraform state list
terraform show
```

## Model Management

Models are configured in `terraform.tfvars` with the following structure:
- `name`: Deployment name
- `model`: Azure OpenAI model type
- `version`: Specific model version
- `capacity`: Deployment capacity (tokens per minute)
- `region`: Azure region for deployment

Different models have specific requirements:
- DALL-E-3 and Whisper use "Standard" SKU
- All other models use "GlobalStandard" SKU

## Security Notes

- Service principal credentials are stored in `azure_credentials.json` (excluded from git)
- Template file `azure_credentials.empty.json` shows required structure for Azure credentials
- Backend configuration contains sensitive storage account details in `config.azurerm.tfbackend`
- Template file `config.azurerm.empty.tfbackend` shows required backend configuration structure
- Access keys are marked as sensitive in Terraform outputs