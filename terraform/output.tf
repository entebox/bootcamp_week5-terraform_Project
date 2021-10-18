#random password
output "vm_password_servers" {
value = nonsensitive(random_password.password.result)
}
#output public ip of web servers
output "srv_public_ips" {
  value       = data.azurerm_public_ip.pubip.*.ip_address
}
