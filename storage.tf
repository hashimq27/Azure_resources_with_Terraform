resource "azurerm_storage_account" "awp" {
  for_each                 = {for acc in local.storage_account_list: "${acc.name}"=> acc}
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.batch06.name
  location                 = azurerm_resource_group.batch06.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  tags = {
    environment = "staging"
  }
}
resource "azurerm_storage_container" "storecont" {
  for_each              = azurerm_storage_account.awp
  name                  = each.value.name
  storage_account_name  = each.value.name
  container_access_type = var.access_type
}

resource "azurerm_storage_blob" "blobstorage" {
  for_each               = azurerm_storage_account.awp
  name                   = each.value.name
  storage_account_name   = each.value.name
  storage_container_name = each.value.name
  type                   = var.storage_type
  source                 = var.storage_source
}