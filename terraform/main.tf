module "naming" {
  source = "Azure/naming/azurerm"

  suffix = [var.workload, var.environment, var.location]
}

resource "azurerm_resource_group" "test" {
  location = var.location
  name     = module.naming.resource_group.name
}

resource "azurerm_container_app_environment" "example" {
  location            = azurerm_resource_group.test.location
  name                = module.naming.container_app_environment.name
  resource_group_name = azurerm_resource_group.test.name
}

module "counting" {
  source                                = "Azure/avm-res-app-containerapp/azurerm"
  container_app_environment_resource_id = azurerm_container_app_environment.example.id
  name                                  = module.naming.container_app.name
  resource_group_name                   = azurerm_resource_group.test.name
  revision_mode                         = "Single"
  template = {
    containers = [
      {
        name   = "juice-shop"
        memory = "0.5Gi"
        cpu    = 0.25
        image  = var.docker_image
      },
    ]
  }
  ingress = {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 3000
    traffic_weight = [{
      latest_revision = true
      percentage      = 100
    }]
  }
}
