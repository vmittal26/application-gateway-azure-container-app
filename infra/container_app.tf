# main.tf (continued)

resource "azurerm_container_app" "containerapp1" {
  name                = var.containerapp1
  resource_group_name = azurerm_resource_group.appgw-rg.name
  revision_mode        = "Single"
  container_app_environment_id =  azurerm_container_app_environment.aca_environment.id

  template {
    container {
      name   = "app"
      image  = var.container_app_1_image
      cpu    = "0.5"
      memory = "1.0Gi"
    }

  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = var.container_port
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azurerm_container_app" "containerapp2" {
  name                = var.containerapp2
  resource_group_name = azurerm_resource_group.appgw-rg.name
  revision_mode        = "Single"
  container_app_environment_id =  azurerm_container_app_environment.aca_environment.id

  template {
    container {
      name   = "app"
      image  = var.container_app_2_image
      cpu    = "0.5"
      memory = "1.0Gi"
    }

  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 3000
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
