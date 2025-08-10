data "azurerm_client_config" "current" {}

output "ai_services_primary_access_key" {
  value     = { for region, c in azurerm_ai_services.aiservices : region => c.primary_access_key }
  sensitive = true
}

output "ai_services_endpoint" {
  value = { for region, c in azurerm_ai_services.aiservices : region => c.endpoint }
}
