resource "azurerm_service_plan" "servplan" {
  for_each            = {for x in local.deployment: x=> x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linwebapp" {
  for_each            = {for x in local.deployment: x=> x}
  name                = each.key
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_service_plan.servplan[each.value].location
  service_plan_id     = azurerm_service_plan.servplan[each.value].id

  site_config {}
}