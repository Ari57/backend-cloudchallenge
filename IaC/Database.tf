resource "azurerm_cosmosdb_account" "example" {
  name                = "iac-cloudresume"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = "uksouth"
    failover_priority = 0
  }

  capabilities {
    name = "EnableMongo"
  }

  capabilities {
    name = "EnableServerless"
  }
}

resource "azurerm_cosmosdb_mongo_database" "example" {
  name                = "iac-db"
  resource_group_name = azurerm_resource_group.example.name
  account_name        = resource.azurerm_cosmosdb_account.example.name
}

resource "azurerm_cosmosdb_mongo_collection" "example" {
  name                = "website-counter"
  resource_group_name = azurerm_resource_group.example.name
  account_name        = resource.azurerm_cosmosdb_account.example.name
  database_name       = azurerm_cosmosdb_mongo_database.example.name

  index {
    keys = ["_id"]
  }
}