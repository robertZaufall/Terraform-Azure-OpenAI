data "azurerm_client_config" "current" {}

output "primary_access_key" {
  value     = { for region, c in azurerm_cognitive_account.cga : region => c.primary_access_key }
  sensitive = true
}

output "endpoint" {
  value = { for region, c in azurerm_cognitive_account.cga : region => c.endpoint }
}