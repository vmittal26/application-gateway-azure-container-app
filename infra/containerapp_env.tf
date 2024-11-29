resource "azurerm_container_app_environment" "aca_environment" {
  name                = var.containerapps_environment_name
  location            = azurerm_resource_group.appgw-rg.location
  resource_group_name = azurerm_resource_group.appgw-rg.name
  internal_load_balancer_enabled = true
  infrastructure_subnet_id       = azurerm_subnet.vnet-appgw-containerapps-subnet.id
  depends_on                     = [azurerm_resource_group.appgw-rg]
}