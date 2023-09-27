resource "azurerm_availability_set" "availset" {
  name                = "example-aset"
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name

  tags = {
    environment = "Production"
  }
}