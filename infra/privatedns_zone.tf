

resource "azurerm_private_dns_zone" "private-dns-zone" {
  name                = azurerm_container_app_environment.aca_environment.default_domain
  resource_group_name = azurerm_resource_group.appgw-rg.name
}
resource "azurerm_private_dns_a_record" "a-record" {
  name                = "@"
  zone_name           = azurerm_private_dns_zone.private-dns-zone.name
  resource_group_name = azurerm_resource_group.appgw-rg.name
  ttl                 = 3600
  records             = [azurerm_container_app_environment.aca_environment.static_ip_address]
}

resource "azurerm_private_dns_a_record" "a-record-wild-card" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.private-dns-zone.name
  resource_group_name = azurerm_resource_group.appgw-rg.name
  ttl                 = 3600
  records             = [azurerm_container_app_environment.aca_environment.static_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-dns-vnet" {
  name                  = "link-dns-vnet"
  resource_group_name   = azurerm_resource_group.appgw-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnet-appgw-container-apps.id
}