resource "azurerm_lb_probe" "probelb" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "ssh-running-probe"
  port            = 22
}