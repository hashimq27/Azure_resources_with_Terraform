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
  name                  = "${var.prefix}cont${var.env}"
  storage_account_name  = azurerm_storage_account.awp.name
  container_access_type = var.access_type
}

resource "azurerm_storage_blob" "blobstorage" {
  for_each               = {for name in local.student_names: name=>name}
  name                   = "${each.key}"
  storage_account_name   = azurerm_storage_account.awp.name
  storage_container_name = azurerm_storage_container.storecont.name
  type                   = var.storage_type
  source                 = var.storage_source
}