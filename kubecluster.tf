resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 name                   = "internal"
 for_each               = {for cluster in local.student_names: cluster=>cluster}
 kubernetes_cluster_id  = "${each.key}"
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "Production"
  }
}