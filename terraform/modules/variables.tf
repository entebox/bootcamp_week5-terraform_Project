#the basic project resource group
variable "resource_group_name" {
  default = "week5-basic-project"
}

#the zone location
variable "location" {
  default = "eastus2"
}

#the subnets
variable "subnet_name" {
  type    = any
  default = ["frontendSubnet", "backendSubnet"]
}

#availability set name
variable "avset" {
  type = string
}
#name of web servers
variable "vm_name" {
  type    = string
  default = "webSrvB"
}
#size of the VMs
variable "srvvm_size" {
  default = "Standard_B1ls"
}

#disk type
variable "managed_disk_type" {
  default = "StandardSSD_LRS"
}

#the vm type postgres or webserver
variable "vm_type" {
  type = string
}

#module index for counting iterations
variable "modu_ind" {
  type = number
}
