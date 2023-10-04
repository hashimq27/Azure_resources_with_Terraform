resource "azurerm_service_plan" "servplan" {
  name                = "example-plan"
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

resource "azurerm_linux_web_app_slot" "linuxappslot" {
  for_each       = azurerm_linux_web_app.linwebapp
  name           = "${var.prefix}-${each.key}"
  app_service_id = each.value.id

  site_config {}
}