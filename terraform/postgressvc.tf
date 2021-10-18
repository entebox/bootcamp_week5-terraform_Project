resource "azurerm_resource_group" "rg_b" {
  name     = var.resource_group_bonus_b
  location = "westus2"
}

resource "azurerm_postgresql_server" "postgsvc" {
  name                = var.postgressvc_name
  location            = "westus2"
  resource_group_name = var.resource_group_bonus_b

  sku_name = var.postgressvc_sku_name

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = var.postgresvc_user_name
  administrator_login_password = var.postgresvc_password
  version                      = var.postgressvc_version
  ssl_enforcement_enabled      = false
}

resource "azurerm_postgresql_database" "db" {
  name                = "app_db"
  resource_group_name = var.resource_group_bonus_b
  server_name         = var.postgressvc_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "postgres_firewall" {
  name                = var.ip_public_name[count.index]
  resource_group_name = var.resource_group_bonus_b
  server_name         = var.postgressvc_name
  start_ip_address    = azurerm_public_ip.webpublicip[count.index]
  end_ip_address      = azurerm_public_ip.webpublicip[count.index]
  count               = length(var.ip_public_name)
  depends_on          = [ azurerm_public_ip.webpublicip ]
}