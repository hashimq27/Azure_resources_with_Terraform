resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location

 managed_rules {
    managed_rule_set {
      version = each.value.version
      rule_group_override {
        rule_group_name = each.value.rule_group_name

        rule {
          id      = each.value.id
          enabled = each.value.enabled
          action  = each.value.action
        }
      }
    }
  }
}
