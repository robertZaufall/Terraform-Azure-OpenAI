locals {
  resource_tags = {
    build   = var.build_number
    release = var.release_number
  }

  models_map = { for ca in var.models : ca.name => ca }

  cga_name       = var.cga_name
  default_region = var.default_region

  ai_regions = distinct([
    for ca in local.models_map : ca.region
  ])
}

resource "azurerm_resource_group" "rg" {
  name     = "x4u-test-ai"
  location = local.default_region
}


resource "azurerm_key_vault" "kv" {
  name                     = "${local.cga_name}-kv"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = local.azure_creds.tenantId
  sku_name                 = "standard"
  purge_protection_enabled = false
}

resource "azurerm_key_vault_access_policy" "kv-ap" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = local.azure_creds.tenantId
  object_id    = local.azure_creds.clientId

  key_permissions = [
    "Create",
    "Get",
    "Delete",
    "Purge",
    "GetRotationPolicy",
  ]
}

resource "azurerm_storage_account" "sa" {
  name                     = "${local.cga_name}sa"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_ai_services" "aiservices" {
  for_each              = toset(local.ai_regions)
  name                  = each.value == local.default_region ? local.cga_name : "${local.cga_name}-${lower(replace(each.value, " ", ""))}"
  location              = each.value
  resource_group_name   = azurerm_resource_group.rg.name
  sku_name              = "S0"
  public_network_access = "Enabled"
  custom_subdomain_name = each.value == local.default_region ? local.cga_name : "${local.cga_name}-${lower(replace(each.value, " ", ""))}"
  network_acls {
    default_action = "Allow"
  }
}

resource "azurerm_ai_foundry" "aihub" {
  for_each            = toset(local.ai_regions)
  name                = each.value == local.default_region ? "${local.cga_name}-hub" : "${local.cga_name}-${lower(replace(each.value, " ", ""))}-hub"
  location            = each.value
  resource_group_name = azurerm_resource_group.rg.name
  storage_account_id  = azurerm_storage_account.sa.id
  key_vault_id        = azurerm_key_vault.kv.id
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_ai_foundry_project" "fp" {
  for_each           = toset(local.ai_regions)
  name               = each.value == local.default_region ? "${local.cga_name}project" : "${local.cga_name}-${lower(replace(each.value, " ", ""))}project"
  friendly_name      = each.value == local.default_region ? "${local.cga_name}-project" : "${local.cga_name}-${lower(replace(each.value, " ", ""))}-project"
  location           = each.value
  ai_services_hub_id = azurerm_ai_foundry.aihub[each.value].id
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_deployment" "cgd" {
  for_each             = local.models_map
  name                 = each.value.model
  cognitive_account_id = azurerm_ai_services.aiservices[each.value.region].id

  model {
    format  = each.value.format
    name    = each.value.model
    version = each.value.version
  }

  sku {
    name     = each.value.sku_name
    capacity = tonumber(each.value.capacity)
  }
}
