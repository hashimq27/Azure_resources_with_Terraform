resource "azurerm_web_application_firewall_policy" "wafpol" {
  name                = "example"
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location

 managed_rules {
    managed_rule_set {
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"

        rule {
          id      = "920440"
          enabled = true
          action  = "Block"
        }
      }
    }
  }
}
