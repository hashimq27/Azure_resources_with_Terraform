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
resource "azurerm_storage_container" "storecont" {
  name                  = "${var.prefix}cont${var.env}"
  storage_account_name  = azurerm_storage_account.awp.name
  container_access_type = var.access_type
}

resource "azurerm_storage_blob" "blobstorage" {
  name                   = "${var.prefix}blob${var.env}"
  storage_account_name   = azurerm_storage_account.awp.name
  storage_container_name = azurerm_storage_container.storecont.name
  type                   = var.storage_type
  source                 = var.storage_source
}