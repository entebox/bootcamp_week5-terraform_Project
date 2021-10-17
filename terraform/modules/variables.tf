  #the zone location
variable "location" {
    default = "eastus2"
}

#the resource group
variable "resource_group" {
    default = "week5-basic-project"
}
# user name for the vms
variable "username" {
  description = "vm user name"
  type        = string
  default = "aviberger"
  sensitive = true
}

#password for the vms
variable "password" {
  description = "vm password"
  type        = string
  default = "Passw0rd1234!"  #not sensetive in-order to output it as requested in the project
}
#managed disk type
variable "managed_disk_type" {
    default = "StandardSSD_LRS"
}