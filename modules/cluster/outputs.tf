// let's define some output vars that aks emits
// https://registry.terraform.io/providers/hashicorp/azurerm/2.17.0/docs/resources/kubernetes_cluster#attributes-reference
output "kube_config" {
    value = azurerm_kubernetes_cluster.aks-transit-api.kube_config_raw
}

output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.aks-transit-api.kube_config.0.cluster_ca_certificate
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.aks-transit-api.kube_config.0.client_certificate
}

output "client_key" {
    value = azurerm_kubernetes_cluster.aks-transit-api.kube_config.0.client_key
}

output "host" {
    value = azurerm_kubernetes_cluster.aks-transit-api.kube_config.0.host
}