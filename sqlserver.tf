resource "azurerm_sql_server" "sqlserv" {
  for_each                     = {for server in local.sql_server_list: "${server.name}"=> server}
  name                         = each.value.name
  resource_group_name          = azurerm_resource_group.batch06.name
  location                     = azurerm_resource_group.batch06.location
  version                      = each.value.version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  tags = {
    environment = "production"
  }
}