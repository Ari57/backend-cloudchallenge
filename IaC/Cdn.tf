resource "azurerm_cdn_profile" "example" {
  name                = "IAC-CloudResume"
  location            = "Global"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "iac-njdscv"
  profile_name        = azurerm_cdn_profile.example.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.example.name

  origin {
    name      = "iac-njdscv"
    host_name = "iacstoragecloudchallenge.z33.web.core.windows.net"

  }
  origin_host_header = "iacstoragecloudchallenge.z33.web.core.windows.net"
  optimization_type  = "GeneralWebDelivery"
}

resource "azurerm_cdn_endpoint_custom_domain" "example" {
  name            = "endpoint-example"
  cdn_endpoint_id = azurerm_cdn_endpoint.example.id
  host_name       = "www.iac-njdscv.com"

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}