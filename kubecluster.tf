resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 name                   = "internal"
 kubernetes_cluster_id  = [for cluster in azurerm_kubernetes_cluster.kube1: cluster.id]
 vm_size               = "Standard_DS2_v2"
 node_count            = 1

  tags = {
    Environment = "Production"
  }
}