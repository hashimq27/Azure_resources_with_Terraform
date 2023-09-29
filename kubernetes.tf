resource "azurerm_kubernetes_cluster" "kube1" {
  for_each            = {for cluster in local.student_names: cluster=> cluster}
  name                = each.key
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
  value     = [for cluster in azurerm_kubernetes_cluster.kube1: cluster.kube_config.0.client_certificate]
  sensitive = true
}

output "kube_config" {
  value = [for cluster in azurerm_kubernetes_cluster.kube1: cluster.kube_config_raw]

  sensitive = true
}