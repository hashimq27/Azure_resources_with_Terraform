locals {
    student_names=["hashim","salik","thomas", "name1", "name2"]
    deployment   =["Val1","Val2", "Val3", "Val4", "Val5", "Val6", "Val7", "Val8", "Val9", "Val10"]
    gateways     =["gateway1", "gateway2", "gateway3", "gateway4", "gateway5"]
    networks     =["network1", "network2", "network3", "network4", "network5"]



    linux_app=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.listoflinuxapp, []) :{
        name=linuxapps.name
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name     
              }
    ]
])

    win_app=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    win_app_list = flatten([
    for app in local.win_app : [
      for winapps in try(app.listofwinapp, []) :{
        name=winapps.name
        os_type=winapps.os_type
        sku_name=winapps.sku_name     
              }
    ]
])

    storageaccount=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    storage_account_list = flatten([
    for account in local.storageaccount : [
      for storageaccs in try(account.listofstorage, []) :{
        name=storageaccs.name
        account_tier=storageaccs.account_tier
        account_replication_type=storageaccs.account_replication_type
              }
    ]
])

    sql_server=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    sql_server_list = flatten([
    for server in local.sql_server : [
      for sqlservers in try(server.listofsqlserver, []) :{
        name=sqlservers.name
        version=sqlservers.version   
              }
    ]
])
    waf_policy=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    waf_policy_list = flatten([
    for waf in local.waf_policy : [
      for policy in try(waf.listofwafpolicies, []) :{
        name=policy.name
        version=policy.managed_rules.managed_rule_set.version
        rule_group_name=policy.managed_rules.managed_rule_set.rule_group_override.rule_group_name
        id=policy.managed_rules.managed_rule_set.rule_group_override.rule.id
        enabled=policy.managed_rules.managed_rule_set.rule_group_override.rule.enabled
        action=policy.managed_rules.managed_rule_set.rule_group_override.rule.action
              }
    ]
])
}
