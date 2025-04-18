locals {
  resource_tags = {
    build   = var.build_number
    release = var.release_number
  }

  models_map = { for ca in var.models : ca.name => ca }

  cga_name = var.cga_name

  openai_regions = distinct([
    for ca in local.models_map : ca.region
  ])
}

resource "azurerm_resource_group" "rg" {
  name     = "OpenAI"
  location = "East US 2"
}

resource "azurerm_cognitive_account" "cga" {
  for_each                      = toset(local.openai_regions)
  name                          = each.value == "East US 2" ? var.cga_name : "${var.cga_name}-${lower(replace(each.value, " ", "-"))}"
  location                      = each.value
  resource_group_name           = azurerm_resource_group.rg.name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  public_network_access_enabled = true
  custom_subdomain_name         = each.value == "East US 2" ? var.cga_name : "${var.cga_name}-${lower(replace(each.value, " ", "-"))}"
  network_acls {
    default_action = "Allow"
  }
}

resource "azurerm_cognitive_deployment" "cgd" {
  for_each             = local.models_map
  name                 = each.value.model
  cognitive_account_id = azurerm_cognitive_account.cga[each.value.region].id

  model {
    format  = "OpenAI"
    name    = each.value.model
    version = each.value.version
  }

  scale {
    type     = (each.value.model == "dall-e-3" || each.value.model == "whisper") ? "Standard" : "GlobalStandard"
    capacity = tonumber(each.value.capacity)
  }
}
