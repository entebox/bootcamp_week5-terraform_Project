variable "admin_username" {
  description = "vm user name"
  type        = string
  sensitive = true
}

variable "nsg_source_ip" {
  sensitive = true
}
