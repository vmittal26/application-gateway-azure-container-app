# main.tf (continued)

resource "azurerm_public_ip" "appgw_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.appgw-rg.location
  resource_group_name = azurerm_resource_group.appgw-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
