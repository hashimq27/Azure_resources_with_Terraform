resource "azurerm_lb_nat_pool" "natpool" {
  resource_group_name            = azurerm_resource_group.batch06.name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "SampleApplicationPool"
  protocol                       = "Tcp"
  frontend_port_start            = 80
  frontend_port_end              = 81
  backend_port                   = 8080
  frontend_ip_configuration_name = "PublicIPAddress"
}