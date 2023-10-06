resource "azurerm_service_plan" "windowservplan" {
  for_each            = {for app in local.win_app_list: "${app.name}"=> app}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location
  sku_name            = each.value.sku_name
  os_type             = each.value.os_type
}

resource "azurerm_windows_web_app" "windowswebbapp" {
  for_each            = azurerm_service_plan.windowservplan
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = each.value.location
  service_plan_id     = each.value.id

  site_config {}
}

resource "azurerm_windows_web_app_slot" "windowsappslot" {
  for_each       = azurerm_windows_web_app.windowswebbapp
  name           = each.key
  app_service_id = each.value.id

  site_config {}
}