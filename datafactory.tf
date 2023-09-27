resource "azurerm_data_factory" "datafact" {
  name                = "example"
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name
}