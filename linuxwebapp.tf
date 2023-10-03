resource "azurerm_service_plan" "servplan" {
  for_each            = {for x in local.deployment: x=> x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name[each.key]
  location            = azurerm_resource_group.batch06.location[each.key]
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linwebapp" {
  for_each            = {for x in local.deployment: x=> x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_service_plan.servplan[each.key]
  service_plan_id     = azurerm_service_plan.servplan[each.key]

  site_config {}
}