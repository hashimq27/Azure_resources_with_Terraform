resource "azurerm_service_plan" "servplan" {
  for_each            = {for app in local.linux_app_list: "${app.name}"=> app}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "linwebapp" {
  for_each            = azurerm_service_plan.servplan
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = each.value.location 
  service_plan_id     = each.value.id

  site_config {}
}

resource "azurerm_linux_web_app_slot" "linuxappslot" {
  for_each       = azurerm_linux_web_app.linwebapp
  name           = "${var.prefix}-${each.key}"
  app_service_id = each.value.id

  site_config {}
}