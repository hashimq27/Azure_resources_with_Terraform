resource "azurerm_data_factory_linked_service_mysql" "linkedserv" {
  name              = "example"
  data_factory_id   = azurerm_data_factory.datafact.id
  connection_string = "Server=test;Port=3306;Database=test;User=test;SSLMode=1;UseSystemTrustStore=0;Password=test"
}

resource "azurerm_data_factory_dataset_mysql" "datasql" {
  name                = "example"
  data_factory_id     = azurerm_data_factory.datafact.id
  linked_service_name = azurerm_data_factory_linked_service_mysql.linkedserv.name
}