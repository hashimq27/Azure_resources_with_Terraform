resource "azurerm_service_plan" "windowservplan" {
  for_each            = {for x in local.deployment: x=>x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "windowswebbapp" {
  for_each            = {for x in local.deployment: x=>x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_service_plan.windowservplan[each.value].location
  service_plan_id     = azurerm_service_plan.windowservplan[each.value].id

  site_config {}
}

resource "azurerm_windows_web_app_slot" "windowsappslot" {
  for_each       = {for x in local.deployment: x=>x}
  name           = each.key
  app_service_id = azurerm_windows_web_app.windowswebbapp[each.value].id

  site_config {}
}