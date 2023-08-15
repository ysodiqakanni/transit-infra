

resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Premium"
  admin_enabled            = false
  //georeplication_locations = ["East US"]
}

# output "acr_login_server" {
#   description = "Login server of the Azure Container Registry"
#   value       = azurerm_container_registry.acr.login_server
# }

# output "acr_repository" {
#   description = "Repository of the Azure Container Registry"
#   value       = azurerm_container_registry.acr.repository
# }

# output "acr_image_tag" {
#   description = "Image tag of the Azure Container Registry"
#   value       = azurerm_container_registry.acr.image_tag
# }