#random password
output "vm_password_servers" {
value = nonsensitive(random_password.password.result)
}
#output the public ip addresses
output "srv_public_ips" {
  value       = data.azurerm_public_ip.pubip.*.ip_address
}
