#the resource group week5 basic project
variable "resource_group_name" {
  default = "week5-basic-project"
}

#the zone location
variable "location" {
  default = "eastus2"
}

variable "webvm_num" {
  type    = list(string)
  default = [ "1","2","3" ]
}

#the virtual network for the servers
variable "vnet" {
  default = "srvs_vnet"
}
#the address space
variable "address_space" {
  default = "10.0.0.0/16"
}
#the subnets
variable "subnet_name" {
  type    = any
  default = ["frontendSubnet", "backendSubnet"]
}
#subnet prefixes
variable "subnet_prefix" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

#os disk of postgres server
variable "postgressrv_os_disk_name" {
  type    = list(string)
  default = ["postgressrv_os_disk"]
}

#web server internal ip name
variable "websrv_ip_internal_name" {
  type    = list(string)
  default = ["webSrv1_internal_ip", "webSrv2_internal_ip", "webSrv3_internal_ip"]
}

#web servers public ip name
variable "ip_public_name" {
  type    = list(string)
  default = ["webSrv1_public_ip", "webSrv2_public_ip", "webSrv3_public_ip"]
}
#Load balancer ip configuration name for each web servers
variable "LB_ip_conf_name" {
  type    = list(string)
  default = ["webSrv1_ip_conf_name", "webSrv2_ip_conf_name", "webSrv3_ip_conf_name"]
}
#Load balancer frontend configuration name for public ip
variable "LB_frontend_conf_name" {
  default = "LBPublicIPAddres"
}
#availability set name
variable "availability_set_name" {
  default = "avset_websrvs"
}

#size of the VMs
variable "srvvm_size" {
  default = "Standard_B1ls"
}

#disk type
variable "managed_disk_type" {
  default = "StandardSSD_LRS"
}
#network security destination port number
variable "nsg_dst_port_num_websrvs" {
  type    = list(string)
  default = ["22", "8080"]
}
#network security rules for the web servers
variable "nsg_rule_name" {
  type    = list(string)
  default = ["SSH", "TCP_8080"]
}
#quantity servers for the module
variable "websrvs_quantity" {
  type        = number
  default = 3
}

variable "postgsrv_quantity" {
  type        = number
  default = 1
}
#web vm name
variable "vm_name" {
  type    = string
  default = "webSrv"
}
