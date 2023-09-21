resource "azurerm_resource_group" "batch06"{
  name= var.prefix
  location="Canada Central"
  
}


resource "azurerm_storage_account" "awp" {
  name                     = "${var.prefix}storage${var.env}"
  resource_group_name      = azurerm_resource_group.batch06.name
  location                 = azurerm_resource_group.batch06.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_blob" "blobstorage" {
  name                   = "${var.prefix}blob${var.env}"
  storage_account_name   = azurerm_storage_account.batch06.name
  storage_container_name = azurerm_storage_container.batch06.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
