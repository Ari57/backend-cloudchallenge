resource "azurerm_service_plan" "example" {
  name                = "IAC-CloudResume"
  resource_group_name = azurerm_resource_group.example.name
  location            = "uksouth"
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "example" {
  name                = "IAC-CounterTrigger"
  resource_group_name = azurerm_resource_group.example.name
  location            = "uksouth"

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id


  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

}