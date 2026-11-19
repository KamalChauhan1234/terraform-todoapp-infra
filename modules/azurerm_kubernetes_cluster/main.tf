resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix
  oidc_issuer_enabled = true   # <-- ye line add karo

  default_node_pool {
    name       = "default"
    node_count = var.node_count 
    vm_size    = var.vm_size 
  }
  
   node_provisioning_profile {
    mode = "Manual"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}