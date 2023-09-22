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

resource "azurerm_kubernetes_cluster" "kube1" {
  name                = var.kube_name
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name
  dns_prefix          = var.kube_dns

  default_node_pool {
    name       = var.pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = var.kube_identity
  }

  tags = {
    Environment = var.kube_env
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kube1.kube_config.0.client_certificate
  sensitive = var.cert_sensitive
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kube1.kube_config_raw

  sensitive = true
}
