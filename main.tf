resource "azurerm_mssql_server" "mssql" {
  name                         = var.mssql_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = "1.2"

  azuread_administrator {
    azuread_authentication_only = true
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

}

resource "azurerm_mssql_firewall_rule" "fw" {
  name             = var.fw_name
  server_id        = azurerm_mssql_server.mssql.id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.62"
}

resource "azurerm_storage_account" "storage" {
  name                              = var.storage_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_kind                      = "StorageV2"
  account_tier                      = "Premium"
  account_replication_type          = var.file_storage_account_replication_type
  enable_https_traffic_only         = true
  allow_nested_items_to_be_public   = true
  infrastructure_encryption_enabled = true
  shared_access_key_enabled         = true

  network_rules {
    default_action = "Deny"
    ip_rules       = ["100.0.0.1"]
    bypass         = ["AzureServices"]
  }

  blob_properties {
    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit" {
  enabled                                 = true
  server_id                               = azurerm_mssql_server.mssql.id
  log_monitoring_enabled                  = true
  retention_in_days                       = 90
}
