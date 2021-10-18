variable "admin_username" {
  description = "vm user name"
  type        = string
  default = "aviberger"
  sensitive = true
}

variable "nsg_source_ip" {
  default = "213.137.80.32/32"
  sensitive = true
}

variable "postgresvc_user_name" {
    type        = string
    default = "postgres"
    sensitive = true
}

variable "postgresvc_password" {
    type        = string
    default = "p@ssw0rd42"
    sensitive = true
}