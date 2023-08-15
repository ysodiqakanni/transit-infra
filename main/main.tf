##################################################################################
# LOCALS
##################################################################################


locals {
  resource_group_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_plan_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  container_app_service_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-withcontainer"
}

resource "random_integer" "name_suffix" {
  min = 10000
  max = 99999
}

##################################################################################
# APP SERVICE
##################################################################################

resource "azurerm_resource_group" "app_service" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_service" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name

  sku {
    tier = var.asp_tier
    size = var.asp_size
    capacity = var.capacity
  }
}

resource "azurerm_app_service" "app_service" {
  name                = local.app_service_name
  location            = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  app_service_plan_id = azurerm_app_service_plan.app_service.id
  
  source_control {
    repo_url = "https://github.com/ysodiqakanni/transit-api"
    branch = "master"
    manual_integration = true
    use_mercurial = false
  }
}

### ACR for hosting our docker images   ####
module "acr" {
  source                = "../modules/azure/"
  acr_name                  = var.container_registry_name
  resource_group_name   = azurerm_resource_group.app_service.name
  location              = azurerm_resource_group.app_service.location
}

module "cluster" {
  source                = "../modules/cluster/"
  # serviceprinciple_id   = var.serviceprinciple_id
  # serviceprinciple_key  = var.serviceprinciple_key
  # ssh_key               = var.ssh_key
  location              = var.location
  kubernetes_version    = var.kubernetes_version  
  
}

/*
# Creating an app service from a container image in ACR
resource "azurerm_app_service" "app_service" {
  name                = local.container_app_service_name
  location            = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  app_service_plan_id = azurerm_app_service_plan.app_service.id

  site_config {
    always_on = true

    # to use image from docker hub:
    #  linux_fx_version = "DOCKER|<docker-image-name>:<tag>"

    # Container settings with ACR image reference
    #linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/${azurerm_container_registry.acr.repository}:${azurerm_container_registry.acr.image_tag}"
    #linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/${azurerm_container_registry.acr.repository}:${azurerm_container_registry.acr.image_tag}"
    linux_fx_version = "DOCKER|${module.acr.acr_login_server}/${module.acr.acr_repository}:${module.acr.acr_image_tag}"
  }

  app_settings = {
    # Additional app settings can be added here if needed
  }

  identity {
    type = "SystemAssigned"
  } 
}
*/

