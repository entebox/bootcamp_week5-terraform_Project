variable "admin_username" {
  description = "vm user name"
  type        = string
  default = "aviberger"
  sensitive = true
}
variable "admin_password" {
  description = "vm password"
  type        = string
  default = "Passw0rd1234!"
}
variable "nsg_source_ip" {
  default = "213.137.80.32/32"
  sensitive = true
}