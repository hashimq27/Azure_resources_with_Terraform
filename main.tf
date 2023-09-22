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
  type                   = var.storage_tyoe
  source                 = var.storage_source
}

resource "azurerm_kubernetes_cluster" "kube1" {
  name                = "example-aks1"
  location            = azurerm_resource_group.batch06.location
  resource_group_name = azurerm_resource_group.batch06.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kube1.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kube1.kube_config_raw

  sensitive = true
}
