resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location

  custom_rules {
    name      = each.value.name
    priority  = each.value.priority 
    rule_type = each.value.rule_type

    match_conditions {
      match_variables {
        variable_name = each.value.variable_name
      }

      operator           = each.value.operator
      negation_condition = each.value.negation_condition
      match_values       = each.value.match_values
    }
    action = each.value.action

   managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = true
          action  = "Log"
        }

        rule {
          id      = "920440"
          enabled = true
          action  = "Block"
        }
      }
    }
  }
}
