resource "azurerm_postgresql_server" "postgsvc" {
  name                = var.postgressvc_name
  location            = "westus2"
  resource_group_name = var.resource_group_name

  sku_name = var.postgressvc_sku_name

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = var.postgresvc_user_name
  administrator_login_password = var.postgresvc_password
  version                      = var.postgressvc_version
  ssl_enforcement_enabled      = false
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_postgresql_database" "db" {
  name                = "app_db"
  resource_group_name = var.resource_group_name
  server_name         = var.postgressvc_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on = [ azurerm_resource_group.rg, azurerm_postgresql_server.postgsvc ]
}

resource "azurerm_postgresql_firewall_rule" "postgres_firewall" {
  name                = "webSrv_public_ip${count.index + 1}"
  resource_group_name = var.resource_group_name
  server_name         = var.postgressvc_name
  start_ip_address    = data.azurerm_public_ip.pubip[count.index].ip_address
  end_ip_address      = data.azurerm_public_ip.pubip[count.index].ip_address
  count               = var.websrvs_quantity
  depends_on          = [ azurerm_public_ip.webpublicip ]
}

data "azurerm_public_ip" "pubip" {
  name                = azurerm_public_ip.webpublicip[count.index].name
  resource_group_name = var.resource_group_name
  count               = var.websrvs_quantity
}
