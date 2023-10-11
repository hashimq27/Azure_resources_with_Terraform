resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location

 managed_rules {
    managed_rule_set {
      version = config.mananged_rule_set.version
      rule_group_override {
        rule_group_name = config.rule_group_override.rule_group_name
        rule {
          id      = config.rule.id
          enabled = config.rule.enabled
          action  = config.rule.action
        }
      }
    }
  }
}
