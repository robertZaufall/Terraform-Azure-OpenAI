# Deploy OpenAI Services with Terraform on Azure

## Login
``` bash
az login

# tenant=AD id
az login --tenant {tenant}

# set active subscription
az account set --subscription "{subscription}"
```

## Create Service Principal and write to file
``` bash
# create service principal with owner role
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/{subscription}" --sdk-auth > azure_credentials.json

# alternative: create service principal with contributor role
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscription}" --sdk-auth > azure_credentials.json
```

## Initialize Terraform and global storage
``` bash
terraform init -backend-config="config.azurerm.tfbackend" -upgrade
```

## Get the cognitive services endpoints and access keys
``` bash
terraform output endpoint
terraform output primary_access_key
```

## Most used terraform commands
``` bash
terraform init
terraform init -backend-config="config.azurerm.tfbackend" -upgrade
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy
terraform show
terraform state list
terraform state
terraform output <output_definition>
```

## Troubleshooting
``` powershell
# get soft deleted cognitive services accounts
az rest --method get --url "https://management.azure.com/subscriptions/a0fe57e5-df87-4e20-875a-9958172c30b1/providers/Microsoft.CognitiveServices/deletedAccounts?api-version=2021-04-30"

# from the cloud console
Get-AzResource -ResourceId /subscriptions/{subscription}/providers/Microsoft.CognitiveServices/deletedAccounts -ApiVersion 2021-04-30

# delete selective instances
az resource delete --ids ...
```
