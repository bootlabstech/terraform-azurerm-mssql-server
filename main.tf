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
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.62"
}
