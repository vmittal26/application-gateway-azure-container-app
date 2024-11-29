# main.tf (continued)

# Virtual Network
resource "azurerm_virtual_network" "vnet-appgw-container-apps" {
  name                = "vnet-appgw-container-apps"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.appgw-rg.location
  resource_group_name = azurerm_resource_group.appgw-rg.name
}

# Subnet for Application Gateway
resource "azurerm_subnet" "vnet-app-gateway-subnet" {
  name                 = "vnet-app-gateway-subnet"
  resource_group_name  = azurerm_resource_group.appgw-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-appgw-container-apps.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Subnet for Container Apps
resource "azurerm_subnet" "vnet-appgw-containerapps-subnet" {
  name                 = "vnet-appgw-containerapps-subnet"
  resource_group_name  = azurerm_resource_group.appgw-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-appgw-container-apps.name
address_prefixes     = ["10.0.4.0/23"]
}

# # Subnet for a VM 
# resource "azurerm_subnet" "vnet-appgw-subnet_vm" {
#   name                 = "vnet-appgw-subnet_vm"
#   resource_group_name  = azurerm_resource_group.appgw-rg.name
#   virtual_network_name = azurerm_virtual_network.vnet-appgw-container-apps.name
# address_prefixes     = ["10.0.2.0/24"]
# }

