# main.tf (continued)

resource "azurerm_application_gateway" "appgw" {
  name                = "app-gateway"
  resource_group_name =  azurerm_resource_group.appgw-rg.name
  location            =  azurerm_resource_group.appgw-rg.location
  depends_on = [ azurerm_container_app_environment.aca_environment]

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.vnet-app-gateway-subnet.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

   backend_http_settings {
    name                                = "appgw-backend-https-settings"
    port                                = 443
    protocol                            = "Https"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true # false
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    request_timeout                     = 20
    path = "/"
  }
  # HTTP Listener
  http_listener {
    name                           = "appgw-http-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  backend_address_pool {
    name = "pool1"
    fqdns =  [azurerm_container_app.containerapp1.ingress[0].fqdn]
  }

   backend_address_pool {
    name = "pool2"
    fqdns =  [azurerm_container_app.containerapp2.ingress[0].fqdn]
  }
   request_routing_rule {
    name                       = "routing-rule"
    priority                   = 1
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "appgw-http-listener"
    url_path_map_name          = "url-path-service-mapping"
  }
  # }
  url_path_map{
      name                               = "url-path-service-mapping"
      default_backend_address_pool_name  = "pool1"
      default_backend_http_settings_name = "appgw-backend-https-settings"
      path_rule {
          name                       = "rule1"
          paths                      = ["/c1","/c1/*"]
          backend_address_pool_name = "pool1"
          backend_http_settings_name = "appgw-backend-https-settings"
      }
      path_rule {
          name                       = "rule2"
          paths                      = ["/c2","/c2/*"]
          backend_address_pool_name = "pool2"
          backend_http_settings_name = "appgw-backend-https-settings"
      }
  }


}