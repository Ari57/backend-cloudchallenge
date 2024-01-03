locals {
  storage_container_name = "$web"
}

resource "azurerm_storage_account" "example" {
  name                     = "iacstoragecloudchallenge"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "uksouth"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "C:\\Users\\njds1\\OneDrive\\Documents\\DevOps\\CloudResumeChallenge\\frontend\\index.html"
  }
}

# resource "azurerm_storage_container" "example" {
#   name                  = "$web"
#   storage_account_name  = azurerm_storage_account.example.name
#   container_access_type = "blob"
# }

resource "azurerm_storage_blob" "html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = local.storage_container_name
  type                   = "Block"
  source                 = "C:\\Users\\njds1\\OneDrive\\Documents\\DevOps\\CloudResumeChallenge\\frontend\\index.html"
}

resource "azurerm_storage_blob" "js" {
  name                   = "index.js"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = local.storage_container_name
  type                   = "Block"
  source                 = "C:\\Users\\njds1\\OneDrive\\Documents\\DevOps\\CloudResumeChallenge\\frontend\\index.js"
}

resource "azurerm_storage_blob" "css" {
  name                   = "styles.css"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = local.storage_container_name
  type                   = "Block"
  source                 = "C:\\Users\\njds1\\OneDrive\\Documents\\DevOps\\CloudResumeChallenge\\frontend\\styles.css"
}

