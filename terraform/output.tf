output "vm_password_servers" {
value = nonsensitive(random_password.password.result)
}
