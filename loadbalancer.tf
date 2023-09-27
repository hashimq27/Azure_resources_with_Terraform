resource "azurerm_public_ip" "publicIP" {
 name                = var.ip_name
 location            = azurerm_resource_group.batch06.location
 resource_group_name = azurerm_resource_group.batch06.name
 allocation_method   = var.method_allocation
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.lb_name
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name

  frontend_ip_configuration {
    name                 = var.ipconfig_name
    public_ip_address_id = azurerm_public_ip.publicIP.id
  }
}