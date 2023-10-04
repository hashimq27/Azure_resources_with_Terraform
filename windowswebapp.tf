resource "azurerm_service_plan" "windowservplan" {
  name                = "example-windows"
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "windowswebbapp" {
  for_each            = {for x in local.deployment: x=>x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_service_plan.windowservplan.location
  service_plan_id     = azurerm_service_plan.windowservplan.id

  site_config {}
}

resource "azurerm_windows_web_app_slot" "windowsappslot" {
  for_each       = azurerm_windows_web_app.windowswebbapp
  name           = each.key
  app_service_id = each.value.id

  site_config {}
}