output "id" {
  description = "AKS cluster resource ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "principal_id" {
  description = "System-assigned identity principal ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}