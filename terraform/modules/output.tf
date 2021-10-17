output "nic_ids" {
  value = azurerm_network_interface.nic
}

output "vm_password_servers" {
value = [var.admin_password]
}