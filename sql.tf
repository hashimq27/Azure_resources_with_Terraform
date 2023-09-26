resource "azurerm_postgresql_server" "sqlserver" {
  name                = "postgresql-server-1"
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name
}

resource "azurerm_postgresql_database" "sqldb" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.batch06.name
  server_name         = azurerm_postgresql_server.sqlserver.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}