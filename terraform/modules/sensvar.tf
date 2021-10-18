variable "admin_username" {
  description = "vm user name"
  type        = string
  sensitive = true
}
variable "admin_password" {
  description = "vm password"
  type        = string
}

variable "nsg_source_ip" {
  sensitive = true
}
